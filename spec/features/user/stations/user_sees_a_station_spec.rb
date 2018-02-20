require 'rails_helper'

context 'As a registered user and admin' do
  describe 'When I visit a station show, in addition to the visitor story' do
    before(:each) do
       @station = create(:station)
       @admin = create(:admin)
       @trips = create_list(:trip, 5, station: @station, start_station_id: @station.id)
       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
     end
    scenario 'I see the Number of rides started at this station' do
      visit station_path(@station)

      expect(page).to have_content("Number of Rides Started at #{@station.name}: 5")
    end
  end
end
# I see the Number of rides ended at this station,
# I see the Most frequent destination station (for rides that began at this station),
# I see the Most freuqnet origination station (for rides that ended at this station),
# I see the Date with the highest number of trips started at this station,
# I see the Most frequent zip code for users starting trips at this station,
# I see the Bike ID most frequently starting a trip at this station.
