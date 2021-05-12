require_relative './bakery_service'
require_relative '../product'

module Service
  class Packer < BakeryService
    def initialize(product_code, quantity)
      @product_code = product_code
      @quantity = quantity
      @breakdown = []
      @cost = 0.00
    end

    def call
      pack

      # Format cost to (2 decimal places)
      @cost = '%.2f' % @cost

      # Return breakdown and cost
      [@breakdown, @cost]
    end

    private

    # Sets the product and returns the available packaging for the said product
    def available_packs
      case @product_code
      when "VS5"
        @product = Product::VegemiteScroll.new
        @product.packs
      when "MB11"
        @product = Product::BlueberryMuffin.new
        @product.packs
      when "CF"
        @product = Product::Croissant.new
        @product.packs
      else
        raise "This product is unavailable!"
      end
    end

    # Calculates the breakdown and cost
    def pack
      last = available_packs.last
      available_packs.each_with_index do |content, index|
        current_is_last = 
        rem = @quantity % content

        # Break loop once quantity reaches 0
        break if @quantity == 0

        # Skip to achieve optimal breakdown of packs
        next_pack = available_packs[index + 1]
        next unless content == last || (rem % next_pack) == 0 || (rem % last) == 0 || (rem < next_pack && last != content)

        # Compute the number of packs
        if last != content && rem < next_pack
          rem = @quantity - content
          packs = 1
          next unless (rem % next_pack) % last == 0
        else
          packs = (@quantity / content).floor()
        end

        # Update product attribute :content
        @product.content = content

        # Update the breakdown and cost
        breakdown = "#{packs} x #{content} $#{@product.price}"
        @breakdown.push(breakdown) unless packs == 0 
        @cost += @product.price * packs

        # Update quantity
        @quantity = rem
      end
    end
  end
end
