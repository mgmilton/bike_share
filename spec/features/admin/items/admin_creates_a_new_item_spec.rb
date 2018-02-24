require 'rails_helper'

context 'As an admin' do
  describe "When I visit '/bike-shop/new'" do
    scenario 'I can create an accessory' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit 'admin/bike-shop/new'

      fill_in 'item[title]', with: 'Sturdy Helmet'
      fill_in 'item[description]', with: 'Practical'
      fill_in 'item[price]', with: 30.59
      click_on 'Create Accessory'

      expect(page).to have_content('Sturdy Helmet')
      expect(page).to have_content('Practical')
      expect(page).to have_content(30.59)
    end
  end
end
