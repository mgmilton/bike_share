require 'rails_helper'

context 'As a registered user and admin' do
  describe"When I visit '/stations-dashboard'" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      @station_1 = create(:station, dock_count: 20, installation_date: Time.strptime('2/8/18', '%m/%d/%y'))
      @station_2 = create(:station, dock_count: 25, installation_date: Time.strptime('4/7/14', '%m/%d/%y'))
      @station_3 = create(:station, dock_count: 10, installation_date: Time.strptime('6/8/14', '%m/%d/%y'))
      @station_4 = create(:station, dock_count: 25, installation_date: Time.now)
      @stations = [@station_1, @station_2, @station_3, @station_4]
    end
    scenario 'I see the Total count of stations' do
      visit '/stations-dashboard'

      expect(page).to have_content("#{@stations.count} Total Stations")
    end

    scenario 'I see the Average bikes available per station (based on docks)' do
      visit '/stations-dashboard'

      expect(page).to have_content('Average Bikes Available Per Station: 20.0')
    end

    scenario 'I see the Most bikes available at a station (Based on docks)' do
      visit '/stations-dashboard'

      expect(page).to have_content("Most Bikes Available at a Station: #{@station_2.dock_count}")
    end

    scenario 'I see the Station(s) where the most bikes are available (based on docks)' do
      visit '/stations-dashboard'

      expect(page).to have_content("Stations with 25 Bikes Available: #{@station_2.name} #{@station_4.name}")
    end

    scenario 'I see the Fewest bikes available at a station (based on docks)' do
      visit '/stations-dashboard'

      expect(page).to have_content("Fewest Bikes Available at a Station: #{@station_3.dock_count}")
    end

    scenario 'I see the Station(s) where the fewest bikes are available (based on docks)' do
      visit '/stations-dashboard'

      expect(page).to have_content("Stations with 10 Bikes Available: #{@station_3.name}")
    end

    scenario 'I see the Most recently installed station' do
      visit '/stations-dashboard'

      expect(page).to have_content("Most Recently Installed Station: #{@station_4.name}")
    end

    scenario 'I also see the Oldest station' do

    end
  end
end
