require_relative './product'
require_relative './service/packer'

class Order
  attr_reader :breakdown, :cost, :output

  def initialize(product_code, quantity)
    @product_code = product_code
    @quantity = quantity
    @breakdown = []
    @cost = 0.00
    @output = ""
  end

  def process
    # Call the packer service
    @breakdown, @cost = Service::Packer.call(@product_code, @quantity)

    # Format the output
    @output += "#{@quantity} #{@product_code} $#{@cost}"
    @breakdown.each { |pack| @output += "\n\t#{pack}" }

    # Return the output, breakdown, and cost
    [@output, @breakdown, @cost]
  end
end
