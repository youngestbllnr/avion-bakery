require_relative '../lib/product'

RSpec.describe 'Product' do
  context 'Vegemite Scroll' do
    subject(:product) { Product::VegemiteScroll.new(3) }

    it 'should return the correct product name' do
      expect(product.name).to eq('Vegemite Scroll')
    end

    it 'should return the correct product code' do
      expect(product.code).to eq('VS5')
    end

    it 'should return the available packs for VS5' do
      expect(product.packs).to eq([5, 3])
    end

    it 'should return the correct price (pack of 3)' do
      expect(product.price).to eq(6.99)
    end
  end

  context 'Blueberry Muffin' do
    subject(:product) { Product::BlueberryMuffin.new(5) }

    it 'should return the correct product name' do
      expect(product.name).to eq('Blueberry Muffin')
    end

    it 'should return the correct product code' do
      expect(product.code).to eq('MB11')
    end

    it 'should return the available packs for MB11' do
      expect(product.packs).to eq([8, 5, 2])
    end

    it 'should return the correct price (pack of 5)' do
      expect(product.price).to eq(16.95)
    end
  end

  context 'Croissant' do
    subject(:product) { Product::Croissant.new(9) }

    it 'should return the correct product name' do
      expect(product.name).to eq('Croissant')
    end

    it 'should return the correct product code' do
      expect(product.code).to eq('CF')
    end

    it 'should return the available packs for CF' do
      expect(product.packs).to eq([9, 5, 3])
    end

    it 'should return the correct price (pack of 9)' do
      expect(product.price).to eq(16.99)
    end
  end
end