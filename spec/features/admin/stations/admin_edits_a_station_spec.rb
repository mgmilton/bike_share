require 'rails_helper'

context 'As an admin' do
  describe "When I visit '/stations/edit fill in all station attributes and click 'Update Station'" do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      @station = create(:station)
      create(:trip, station: @station)
    end
    scenario "I am directed that station's show page" do
      visit edit_admin_station_path(@station)

      expect(page).to have_field('station[name]', with: @station.name)
      expect(page).to have_field('station[dock_count]', with: @station.dock_count)
      expect(page).to have_field('station[city]', with: @station.city)
      expect(page).to have_field('station[installation_date]', with: @station.installation_date)
      expect(page).to have_field('station[latitude]', with: @station.latitude)
      expect(page).to have_field('station[longitude]', with: @station.longitude)

      fill_in 'station[name]', with: 'Mountain Vista'
      fill_in 'station[dock_count]', with: 10
      select('San Jose', from: 'station[city]')
      fill_in 'station[installation_date]', with: Date.today
      fill_in 'station[latitude]', with: 127.1332341
      fill_in 'station[longitude]', with: (-114.16272341)
      click_on 'Update Station'

      expect(current_path).to eq(station_path(@station))
      expect(page).to have_content('Mountain Vista')
      expect(page).to have_content(10)
      expect(page).to have_content('San Jose')
      expect(page).to have_content(Date.today)
      expect(page).to have_content(127.1332341)
      expect(page).to have_content(-114.16272341)
      expect(page).to have_content('Mountain Vista updated succesfully')
    end
  end
end
