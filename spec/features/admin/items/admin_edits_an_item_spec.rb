require 'rails_helper'

context 'As an admin' do
  before(:each) do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    @active = create(:item)
    @retired = create(:item, status: 'retired')
  end
  describe 'when I visit admin bike-shop path and click edit, fill in the info and submit' do
    scenario 'I can edit that item' do
      visit admin_items_path

      find(".edit-#{@active.id}").click

      fill_in 'item[title]', with: 'Bike Light'
      fill_in 'item[description]', with: 'Drivers Can See You'
      fill_in 'item[price]', with: 20.00
      click_on 'Update Accessory'

      expect(page).to have_content('Bike Light')
      expect(page).to have_content('Drivers Can See You')
      expect(page).to have_content(20.00)
    end
  end
  describe 'when I visit admin bike-shop path and click retire next to an item' do
    scenario 'I can retire that item' do
      visit admin_items_path
      expect(@active.status).to eq('active')

      find(".retire-#{@active.id}").click

      expect(page).to have_content('retired')
      expect(page).to have_link('Reactivate')
    end
  end

  describe 'when I visit admin bike-shop path and click reactivate next to a retired item' do
    scenario 'I can reactivate that item' do
      visit admin_items_path

      expect(@retired.status).to eq('retired')
      expect(page).to have_content('retired')
      expect(page).to have_link('Reactivate')

      find(".reactivate-#{@retired.id}").click

      expect(page).to_not have_content('retired')
      expect(page).to_not have_link('Reactivate')
    end
  end
end
