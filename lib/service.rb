require_relative './product'

module Service
  class BakeryService
    def self.call(*args, &block)
      new(*args, &block).call
    end
  end
  
  class Cashier < BakeryService
    attr_accessor :total

    def initialize(cart)
      @cart = cart
      @total = 0.00
    end

    def call
      puts "\nORDERS:"

      # Loop through the orders on the cart
      @cart.orders.each do |order|
        output, breakdown, cost = order

        # Print out each order
        puts output

        # Increment total cost
        @total += cost.to_f
      end

      # Format total to 2 decimal places
      @total = '%.2f' % @total

      # Print out total
      puts "\nTOTAL: $#{@total}"
      @total
    end
  end

  class Packer < BakeryService
    def initialize(product_code, quantity)
      @product_code = product_code
      @quantity = quantity
      @breakdown = []
      @cost = 0.00
    end

    def call
      pack

      # Format cost
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
        rem = @quantity % content

        # Break loop once quantity reaches 0
        break if @quantity == 0

        # Skip to achieve optimal breakdown of packs
        next_pack = available_packs[index + 1]
        next unless content == last || (rem % next_pack) == 0 || (rem % last) == 0

        # Compute the number of packs
        packs = (@quantity / content).floor()

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
