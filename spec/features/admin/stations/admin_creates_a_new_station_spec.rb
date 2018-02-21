require 'rails_helper'

context 'As an admin' do
  describe "When I visit '/stations/new', I fill in a form with all station attributes, and click 'Create Station'" do
    scenario "I am directed to that station's show page and see a flash message that I have created that station." do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_station_path

      fill_in 'station[name]', with: 'Mountain Vista'
      fill_in 'station[dock_count]', with: 10
      select('San Jose', from: 'station[city]')
      fill_in 'station[installation_date]', with: Date.today
      fill_in 'station[latitude]', with: 127.1332341
      fill_in 'station[longitude]', with: (-114.16272341)
      click_on 'Create Station'

      expect(current_path).to eq('/stations/mountain-vista')
      expect(page).to have_content('Mountain Vista created succesfully')
      expect(page).to have_content('Dock Count: 10')
      expect(page).to have_content('San Jose')
      expect(page).to have_content(127.1332341)
      expect(page).to have_content(-114.16272341)
      expect(page).to have_content(Date.today)
    end
  end
end
