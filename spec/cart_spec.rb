require_relative '../lib/cart'

RSpec.describe 'Cart' do
  subject(:cart) { Cart.new }

  it 'should store orders in an array' do
    expect(cart.orders).to be_an_instance_of(Array)
  end

  context 'add' do
    it 'should add an order to the cart' do
      cart.add('VS5', 24)

      expect(cart.orders.length).not_to eq(0)
    end
  end
end