require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.create!(name: 'electronics')
      # Setup at least two products with different quantities, names, etc
      @product1 = @category.products.create!(name: 'red sweater', price: 20.00, quantity: 10)
      @product2 = @category.products.create!(name: 'candy cane', price: 3.99, quantity: 100)
      # Setup at least one product that will NOT be in the order
      @product3 = @category.products.create!(name: 'antique light bulb', price: 15.00, quantity: 2)
    end
    # pending test 1
    xit 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: 'test@gmail.com',
        total_cents: 20,
        stripe_charge_id: stripe_charge.id, # returned by stripe
      )
      # 2. build line items on @order
      # ...
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      # ...
    end
    # pending test 2
    xit 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
    end
  end
end