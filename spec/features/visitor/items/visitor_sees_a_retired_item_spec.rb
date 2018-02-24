require 'rails_helper'

context 'As a visitor' do
  describe 'When I visit an accessory show for a retired accessory' do
    before(:each) do
      @accessory = create(:item, status: 1)
    end
    scenario 'I am still able to access the accessory page' do
      visit "bike-shop/#{@accessory.id}"

      expect(page).to have_content(@accessory.title)
      expect(page).to have_content(@accessory.description)
      expect(page).to have_content(@accessory.price)
      expect(page).to have_content("Accessory Retired")
      expect(page).to_not have_button('Add To Cart')
    end
  end
end

# I am not able to add the accessory to my cart,
# I also see in place of the "Add to Cart" button or link - "Accessory Retired
