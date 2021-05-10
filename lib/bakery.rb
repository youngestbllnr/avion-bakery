require_relative './cart'
require_relative './service'
require 'tty/prompt'

class Bakery
  attr_accessor :cart
  
  def initialize
    @cart = Cart.new
    @prompt = TTY::Prompt.new

    # Set available product
    @products = [
      { key: "VS5", name: "Vegemite Scroll", value: "VS5" },
      { key: "MB11", name: "Blueberry Muffin", value: "MB11" },
      { key: "CF", name: "Croissant", value: "CF" }
    ]

    # Messages
    @welcome_message = "Welcome to Avion Bakery!\n"
    @receipt_border_top = "\n--------RECEIPT--------"
    @receipt_border_bottom = "\n-----END OF RECEIPT-----"
    @exit_message = "\nThank you for your purchase! Please come again."
    @continue_shopping_message = "\nWould you like to purchase more products?"
  end
  
  def enter
    print @welcome_message
    @welcome_message
  end

  def shop
    add_to_cart_prompt
    while @prompt.yes?(@continue_shopping_message)
      add_to_cart_prompt
    end
    @cart
  end

  def pay
    puts @receipt_border_top
    total = Service::Cashier.call(@cart)
    puts @receipt_border_bottom
    total
  end

  def leave
    puts @exit_message
    @exit_message
  end

  private

  # Gets an order from the user and adds it to the cart
  def add_to_cart_prompt
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

  # Returns a product object based on the product_code
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
