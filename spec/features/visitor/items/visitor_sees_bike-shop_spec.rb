require 'rails_helper'

context 'As a visitor' do
  describe "When I visit '/bike-shop'" do
    before(:each) do
      @accessories = create_list(:item, 12)
    end
    scenario 'I see at least 12 bike accessories (items) for sale' do
      visit '/bike-shop'

      @accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
      end
    end
  end
end

# I see a button near each item that says "Add to Cart"
# When I click "Add to Cart",
# I see a flash message alerting me that I have added that specific accessory to my cart.
# I also see my cart count updated on all pages.
