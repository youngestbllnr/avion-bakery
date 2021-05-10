require_relative './order'

class Cart
  attr_reader :orders

  def initialize
    @orders = []
  end

  # Adds an order to the cart
  def add(product_code, quantity)
    order = Order.new(product_code, quantity)
    order = order.process
    
    @orders.push(order)
  end
end