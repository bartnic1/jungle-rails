require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js:true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name: 'test',
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

    scenario "the cart total increases by 1" do
      # ACT
      visit root_path
      click_link 'Add'

      # DEBUG
      # save_screenshot

      # VERIFY
      within('nav.navbar') { expect(page).to have_content('My Cart (1)') }
    end
end