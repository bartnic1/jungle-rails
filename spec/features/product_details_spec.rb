require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  'test',
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "can navigate to product page", js: true do
  # ACT
  visit root_path
  click_link 'test'
  # DEBUG
  # save_screenshot

  # VERIFY
  expect(page).to have_css 'article.product-detail'
  end
end
