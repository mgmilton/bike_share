require 'rails_helper'

context 'As a registered user and admin' do
  describe"When I visit '/stations-dashboard'" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      station_1 = create(:station, dock_count: 20)
      station_2 = create(:station, dock_count: 25)
      station_3 = create(:station, dock_count: 10)
      station_4 = create(:station, dock_count: 10)
      @stations = [station_1, station_2, station_3, station_4]
    end
    scenario 'I see the Total count of stations' do
      visit '/stations-dashboard'

      expect(page).to have_content("#{@stations.count} Total Stations")
    end

    scenario 'I see the Average bikes available per station (based on docks)' do
      visit '/stations-dashboard'

      expect(page).to have_content('Average Bikes Available Per Station: 16.25')
    end

    scenario 'I see the Most bikes available at a station (based on docks)' do
      visit '/stations-dashboard'

      expect(page).to have_content('Most bikes available at a station: 25')
    end
  end
end

# I see the Station(s) where the most bikes are available (based on docks),
# I see the Fewest bikes available at a station (based on docks),
# I see the Station(s) where the fewest bikes are available (based on docks),
# I see the Most recently installed station,
# I also see the Oldest station.
