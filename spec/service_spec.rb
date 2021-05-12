require_relative '../lib/service/cashier'
require_relative '../lib/service/packer'

RSpec.describe 'Service' do
  context 'Cashier' do
    it 'should process the orders in the cart' do
      cart = Cart.new
      cart.add('VS5', 24)

      total = Service::Cashier.call(cart)

      expect(total).to eq('55.92')
    end
  end

  context 'Packer' do
    it 'should determine the optimal packaging' do
      breakdown, cost = Service::Packer.call('VS5', 13)

      expect(breakdown).to eq(['2 x 5 $8.99', '1 x 3 $6.99'])
    end
  end
end