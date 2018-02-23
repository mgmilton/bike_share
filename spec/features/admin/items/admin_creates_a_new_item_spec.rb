require 'rails_helper'

context 'As an admin' do
  describe "When I visit '/bike-shop/new'" do
    scenario 'I can create an accessory' do
      visit 'bike-shop/new'

      fill_in 'item[title]', with: 'Sturdy Helmet'
      fill_in 'item[description]', with: 'Practical'
      fill_in 'item[price]', with: 30.59
      # fill_in 'item[photo]', with: 30.59

      click_on 'Create Item'

      expect(current_path).to eq()
      expect(page).to have_content('Sturdy Helmet')
      expect(page).to have_content('Practical')
      expect(page).to have_content(30.59)
    end
  end
end
