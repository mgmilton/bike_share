require 'rails_helper'

context 'As an admin' do
  describe 'When I visit "/admin/dashboard"' do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    scenario 'I see a link for viewing all accessories' do
      visit admin_dashboard_path

      expect(page).to have_link('Bike Shop Accessories')
    end
  end
end
#
# When I click that link,
# My current path should be "/admin/bike-shop",
# I see a table with all accessories (active and inactive)
#
# Each accessory should have:
#
# A thumbnail of the image
# Description
# Status
# Ability to Edit accessory
# Ability to Retire/Reactivate accessory
