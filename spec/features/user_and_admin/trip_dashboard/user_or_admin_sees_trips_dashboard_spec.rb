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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  describe "when i visit the trips_dashboard_path" do
    it "shows the average duration of a ride" do
      visit trips_dashboard_path

      expect(page).to have_content("Average Trip Duration: 0.18 Hours")
    end

    it "shows the longest ride" do
      visit trips_dashboard_path

      expect(page).to have_content("Longest Trip Duration: 0 Hours")
    end

    it "shows the shortest ride" do
      visit trips_dashboard_path

      expect(page).to have_content("Shortest Trip Duration: 0 Hours")
    end

    it "shows monthly breakdown" do
      visit trips_dashboard_path

      expect(page).to have_content("Total Rides By Month")
      expect(page).to have_content("3")
    end

    it "shows most ridden bike with number of rides" do
      visit trips_dashboard_path

      expect(page).to have_content("Most Ridden Bike: #{@trip1.bike_id} with 2 rides")
    end

    it "shows least ridden bike with number of rides" do
      visit trips_dashboard_path

      expect(page).to have_content("Least Ridden Bike: #{@trip3.bike_id} with 1 rides")
    end

    it "shows user types with number and percentage" do
      visit trips_dashboard_path

      expect(page).to have_content("2 Subscribers make up 66.67% of Total Users")
      expect(page).to have_content("1 Customers make up 33.33% of Total Users ")
    end

    it "shows the highest trip date with number of trips" do
      visit trips_dashboard_path

      expect(page).to have_content("Busiest Day: 2 rides on 2020-08-27")
      expect(page).to have_content("Slowest Day: 1 rides on 2020-12-25")
    end

    it "shows the station with the most starting rides" do
      visit trips_dashboard_path

      expect(page).to have_content("Station With Most Starting Rides: #{@station1.name}")
    end

    it "shows the station with the most ending rides" do
      visit trips_dashboard_path

      expect(page).to have_content("Station With Most Ending Rides: #{@station2.name}")
    end

    it "shows the weather for the busiest day" do
      visit trips_dashboard_path

      expect(page).to have_content("Weather For Busiest Day: High Temperature: #{@condition_1.max_temperature} Lowest Temperature: #{@condition_1.min_temperature} Precipitation: #{@condition_1.mean_precipitation}")
    end

    it "shows the weather for the slowest day" do
      visit trips_dashboard_path

      expect(page).to have_content("Weather For Slowest Day: High Temperature: #{@condition_2.max_temperature} Lowest Temperature: #{@condition_2.min_temperature} Precipitation: #{@condition_2.mean_precipitation}")
    end
  end
end
