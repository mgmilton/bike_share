require "rails_helper"

describe "as a registered user or admin" do
  before :each do
    @admin = create(:admin)
      @user = create(:user)
      @station1 = create(:station, name: "station 1")
      @station2 = create(:station, name: "station 2")
      @condition_1 = create(:condition, date: Date.strptime("08/27/2015", "%m/%e/%y"))
      @condition_2 = create(:condition, date: Date.strptime("12/25/2014", "%m/%e/%y"), max_temperature: 30, min_temperature: 20, mean_precipitation: 2)
      @trip1 = create(:trip, duration: 10, start_station_id: @station1.id, end_station_id: @station1.id, start_date: Date.strptime("08/27/2015", "%m/%e/%y"))
      @trip2 = create(:trip, duration: 20, zip_code: 95113, bike_id: @trip1.bike_id, start_station_id: @station1.id, end_station_id: @station2.id, start_date: Date.strptime("12/25/2014", "%m/%e/%y"))
      @trip3 = create(:trip, duration: 3, bike_id: 10, subscription_type: "Customer", zip_code: 94041, start_station_id: @station1.id, end_station_id: @station2.id, start_date: Date.strptime("08/27/2015", "%m/%e/%y"))
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)  end
  describe "when i visit the trips_dashboard_path" do
    it "shows the average duration of a ride" do
      visit trips_dashboard_path

      expect(page).to have_content("Average Trip Duration: 11")
    end

    it "shows the longest ride" do
      visit trips_dashboard_path

      expect(page).to have_content("Longest Trip Duration: 20")
    end

    it "shows the shortest ride" do
      visit trips_dashboard_path

      expect(page).to have_content("Shortest Trip Duration: 3")
    end

    it "shows monthly breakdown" do
      visit trips_dashboard_path
      # I see Month by Month breakdown of number of rides with subtotals for each year,
      # needs to be tweaked
      expect(page).to have_content("Total Rides By Month")
      expect(page).to have_content("3")
    end

    it "shows most ridden bike with number of rides" do
      visit trips_dashboard_path

      expect(page).to have_content("Most Ridden Bike: #{@trip1.bike_id} With 2 Rides")
    end
  end
end


# I see the Most ridden bike with total number of rides for that bike,
# I see the Least ridden bike with total number of rides for that bike,


# I see the Station with the most rides as a starting place,
# I see the Station with the most rides as an ending place,
# I see the User subscription type breakout with both count and percentage,
# I see the Single date with the highest number of trips with a count of those trips,
# I see the Single date with the lowest number of trips with a count of those trips.
