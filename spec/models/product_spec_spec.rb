require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.new(name: 'TestCategory') }

    it 'is valid with valid attributes' do
      product = Product.new(name: 'TestProduct', price_cents: 100, quantity: 10, category: category)  
      expect(product).to be_valid
    end
    # validates :name, presence: true
    it 'is not valid without a name' do
      product = Product.new(name: nil, price_cents: 100, quantity: 10, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    # validates :price, presence: true
    it 'is not valid without a price' do
      product = Product.new(name: 'Test Product', price_cents: nil, quantity: 10, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    # validates :quantity, presence: true
    it 'is not valid without a quantity' do
      product = Product.new(name: 'TestProduct', price_cents: 100, quantity: nil, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    # validates :category, presence: true
    it 'is not valid without a category' do
      product = Product.new(name: 'TestProduct', price_cents: 100, quantity: 10, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
