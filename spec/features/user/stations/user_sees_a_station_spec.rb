require 'rails_helper'

context 'As a registered user and admin' do
  describe 'When I visit a station show, in addition to the visitor story' do
    before(:each) do
       @station_1 = create(:station)
       @station_2 = create(:station)
       @admin = create(:admin)
       create_list(:trip, 2, station: @station_1, start_station_id: @station_1.id, end_station_id: @station_1.id)
       create_list(:trip, 3, station: @station_1, start_station_id: @station_1.id, end_station_id: @station_2.id)
       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
     end

    scenario 'I see the Number of rides started at this station' do
      visit station_path(@station_1)

      expect(page).to have_content("Number of Rides Started at #{@station_1.name}: 5")
    end

    scenario 'I see the Number of rides ended at this station' do
      visit station_path(@station_1)

      expect(page).to have_content("Number of Rides Ended at #{@station_1.name}: 2")
    end

    scenario 'I see the Most frequent destination station (for rides that began at this station)' do
      visit station_path(@station_1)

      expect(page).to have_content("Most Frequent Destination Station: #{@station_2.name}")
    end

    scenario 'I see the Most frequent origination station (for rides that ended at this station)' do
      visit station_path(@station_1)

      expect(page).to have_content("Most Frequent Origination Station: #{@station_1.name}")
    end
  end
end
# I see the Date with the highest number of trips started at this station,
# I see the Most frequent zip code for users starting trips at this station,
# I see the Bike ID most frequently starting a trip at this station.
