require_relative '../lib/order'

RSpec.describe 'Order' do
  subject(:order) { Order.new('VS5', 24) }

  context 'process' do
    it 'should return the correct output, breakdown, and cost' do
      output = "24 VS5 $55.92\n\t8 x 3 $6.99"
      breakdown = ['8 x 3 $6.99']
      cost = '55.92'

      expect(order.process).to eq([output, breakdown, cost])
    end
  end
end