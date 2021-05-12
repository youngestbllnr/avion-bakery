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
      available_packs.each_with_index do |content, index|

        # Break loop once quantity reaches 0
        break if @quantity == 0

        # Compute the number of packs
        packs = packs_for_content(content, index)
        
        # Update product attribute :content
        @product.content = content

        # Update the breakdown and cost
        breakdown = "#{packs} x #{content} $#{@product.price}"
        @breakdown.push(breakdown) unless packs == 0 
        @cost += @product.price * packs
      end
    end

    # Calculates how many packs should be bought to achieve optimal packaging
    def packs_for_content(content, index)
      # Set variables
      next_pack = available_packs[index + 1]
      last_pack = available_packs.last
      not_last = content != last_pack
      packs = 0
      
      # Loop
      while @quantity >= content do
        break if not_last && ((@quantity % next_pack == 0 || @quantity % last_pack == 0) || (@quantity - content) < next_pack)
        @quantity = @quantity - content
        packs += 1
      end

      # Return packs
      packs
    end
  end
end
