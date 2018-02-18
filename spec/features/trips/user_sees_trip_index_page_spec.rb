require "rails_helper"

describe "as a visitor" do
  describe "when i visit the trips index" do
    it "i see the first thirty trips with all attributes" do
      trips = create_list(:trip, 30)
      trip_31 = create(:trip)

      visit trips_path

      trips.each do |trip|
        expect(page).to have_content(trip.duration)
        expect(page).to have_content(trip.start_date)
        expect(page).to have_content(trip.start_station_id)
        expect(page).to have_content(trip.end_date)
        expect(page).to have_content(trip.end_station_id)
        expect(page).to have_content(trip.bike_id)
        expect(page).to have_content(trip.subscription_type)
        expect(page).to have_content(trip.zip_code)
      end
      expect(page).to have_content("30 Most Recent Trips")
      expect(page).to_not have_content(trip_31.bike_id)
    end

    it "shows a link to a page with more trips" do
      trips = create_list(:trip, 30)

      visit trips_path

      # expect(page).to have_link("View More Trips")

    end
  end
end



#
# I also see a button to see more pages of trips,
#
# When I visit a second page, there should be buttons to move both forward and backward in time.
#
# ** All Attributes must be present **
