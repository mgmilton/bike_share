require 'rails_helper'

context 'As an admin' do
  describe 'When I visit "/admin/dashboard"' do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      @accessories = create_list(:item, 12)
    end
    scenario 'I see a link for viewing all accessories' do
      visit admin_dashboard_path

      expect(page).to have_link('Bike Shop Accessories')
    end

    describe 'When I click that link' do
      scenario 'My current path should be "/admin/bike-shop"' do
        visit admin_dashboard_path
        click_link 'Bike Shop Accessories'

        expect(current_path).to eq('/admin/bike-shop')
      end
    end

    scenario 'I see a table with all accessories (active and inactive)' do
      visit admin_dashboard_path
      click_link 'Bike Shop Accessories'

      @accessories.each do |item|
        expect(page).to have_xpath("//img[contains(@src,'#{item.image.url}')]")
        expect(page).to have_content(item.title)
        expect(page).to have_content(item.description)
        within(".item-#{item.slug}") do
          expect(page).to have_link("Edit")
          expect(page).to have_link("Retire")
          expect(page).to have_content(item.status)
        end
      end
    end

    scenario 'I see a link to reactivate an item if the item is retired' do
      @accessories.first.retired!
      visit admin_dashboard_path
      click_link 'Bike Shop Accessories'

      within(".item-#{@accessories.first.slug}") do
        expect(page).to have_link('Reactivate')
      end
    end
  end
end
