require_relative './product'
require_relative './service'

class Order
  attr_reader :breakdown, :cost

  def initialize(product_code, quantity)
    @product_code = product_code
    @quantity = quantity
    @breakdown = []
    @cost = 0.00
  end

  def process
    # Call the packer service
    @breakdown, @cost = Service::Packer.call(@product_code, @quantity)

    # Format the output
    output = "#{@quantity} #{@product_code} $#{@cost}"
    @breakdown.each { |pack| output += "\n\t#{pack}" }

    # Return the output
    [output, @breakdown, @cost]
  end
end
