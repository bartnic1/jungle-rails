require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:category) }

    before :each do
      @category = Category.create(name: 'Electronics')
    end

    context 'have errors' do
      it 'if quantity is undefined' do
        @product = @category.products.create({name: 'test', price: 1})
        expect(@product.errors.full_messages).to include('Quantity can\'t be blank')
      end
      it 'if price is undefined' do
        @product = @category.products.create({name: 'test', quantity: 1})
        expect(@product.errors.full_messages).to include('Price can\'t be blank')
      end
      it 'if name is undefined' do
        @product = @category.products.create({quantity: 1, price: 1})
        expect(@product.errors.full_messages).to include('Name can\'t be blank')
      end
      it 'if category is undefined' do
        @product = Product.create({name: 'test', quantity: 1, price: 1})
        expect(@product.errors.full_messages).to include('Category can\'t be blank')
      end
    end
  end
end
