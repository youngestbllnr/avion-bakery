require_relative '../lib/bakery'

RSpec.describe 'Bakery' do
  subject(:bakery) { Bakery.new }

  context 'enter_bakery' do
    it 'should print out a welcome message to the customer' do
      expect(bakery.enter_bakery).to eq("Welcome to Avion Bakery!\n")
    end
  end

  context 'pay' do
    it 'should process the orders and return the total' do
      bakery.cart.add("VS5", 24)

      expect(bakery.pay).not_to eq(0)
    end
  end

  context 'exit_bakery' do
    it 'should print out an exit message to the customer' do
      expect(bakery.exit_bakery).to eq("\nThank you for your purchase! Please come again.")
    end
  end
end