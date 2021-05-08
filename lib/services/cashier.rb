#module Service
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

      # Prin out total
      puts "\nTOTAL: $#{@total}"
    end
  end
#end