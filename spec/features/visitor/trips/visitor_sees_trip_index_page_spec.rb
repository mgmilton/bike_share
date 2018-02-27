require "rails_helper"

describe "as a visitor" do
  describe "when i visit the trips index" do
    it "i see the first thirty trips with all attributes" do
      station = create(:station, id: 999)
      trips = create_list(:trip, 30, start_station_id: 999, end_station_id: 999)
      trip_31 = create(:trip, start_station_id: 999, end_station_id: 999)

      visit trips_path

      trips.each do |trip|
        expect(page).to have_content(trip.duration)
        expect(page).to have_content(trip.start_date)
        expect(page).to have_content(station.name)
        expect(page).to have_content(trip.end_date)
        expect(page).to have_content(station.name)
        expect(page).to have_content(trip.bike_id)
        expect(page).to have_content(trip.subscription_type)
        expect(page).to have_content(trip.zip_code)
      end
      expect(page).to have_content("30 Most Recent Trips")

      expect(page).to_not have_content("Bike Used: #{trip_31.bike_id}")
    end

    it "shows a link to a page with more trips" do
      station = create(:station, id: 999)
      create_list(:trip, 90, start_station_id: 999, end_station_id: 999)

      visit trips_path

      expect(page).to have_link("Next 30 Trips")
      expect(page).to_not have_link("Previous 30 Trips")

      click_link "Next 30 Trips"

      expect(page).to have_link("Next 30 Trips")
      expect(page).to have_link("Previous 30 Trips")

      click_link "Next 30 Trips"

      expect(page).to have_link("Next 30 Trips")
      expect(page).to have_link("Previous 30 Trips")

      click_link "Next 30 Trips"

      expect(page).to_not have_link("Next 30 Trips")
      expect(page).to have_link("Previous 30 Trips")

      click_link "Previous 30 Trips"

      expect(page).to have_link("Next 30 Trips")
      expect(page).to have_link("Previous 30 Trips")

      click_link "Previous 30 Trips"

      expect(page).to have_link("Next 30 Trips")
      expect(page).to have_link("Previous 30 Trips")

      click_link "Previous 30 Trips"

      expect(page).to have_link("Next 30 Trips")
      expect(page).to_not have_link("Previous 30 Trips")
    end
  end
end
