require_relative './order'

class Cart
  attr_reader :orders

  def initialize
    @orders = []
  end

  # Adds an order to the cart
  def add(product_code, quantity)
    new_order = Order.new(product_code, quantity).process
    @orders.push(new_order)
  end
end