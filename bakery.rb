require_relative './lib/cart'
require_relative './lib/services/cashier'
require 'tty/prompt'

class Bakery
  def initialize
    @cart = Cart.new
    @prompt = TTY::Prompt.new
    @products = [
      { key: "VS5", name: "Vegemite Scroll", value: "VS5" },
      { key: "MB11", name: "Blueberry Muffin", value: "MB11" },
      { key: "CF", name: "Croissant", value: "CF" }
    ]
  end
  
  def enter_bakery
    puts "Welcome to Avion Bakery!\n"
  end

  def shop
    add_to_cart
    while @prompt.yes?("\nWould you like to purchase more products?")
      add_to_cart
    end
  end

  def pay
    puts "\n--------RECEIPT--------"
    Cashier.call(@cart)
    puts "\n-----END OF RECEIPT-----"
  end

  def exit_bakery
    puts "\nThank you for your purchase! Please come again."
  end

  private

  def add_to_cart
    # Get the product that the user wants to buy
    product_ask = "\nWhat would you like to buy?"
    product_code = @prompt.select(product_ask, @products)
    selected_product = product(product_code)

    # Get the quantity that the user wants to buy
    minimum_quantity = selected_product.packs.last
    quantity_ask = "How many #{selected_product.name} would you like to purchase?\n[Minimum of #{minimum_quantity}]:"
    quantity = @prompt.ask(quantity_ask, convert: :int)
    
    # Add to cart
    if quantity < minimum_quantity
      puts "Sorry, #{selected_product.name} can't be sold in packs of #{quantity}."
    else
      @cart.add(product_code, quantity)
    end
  end

  def product(product_code)
    case product_code
    when "VS5"
      Product::VegemiteScroll.new
    when "MB11"
      Product::BlueberryMuffin.new
    when "CF"
      Product::Croissant.new
    else
      raise "This product is unavailable!"
    end
  end
end

# Execute the program
bakery = Bakery.new
bakery.enter_bakery
bakery.shop
bakery.pay
bakery.exit_bakery
