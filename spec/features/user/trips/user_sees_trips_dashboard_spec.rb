require "rails_helper"

describe "as a registered user or admin" do
  before :each do
    @admin = create(:admin)
    @user = create(:user)
    @station1 = create(:station, name: "station 1")
    @station2 = create(:station, name: "station 2")
    @condition_1 = create(:condition, date: Date.strptime("03/21/2017", "%m/%e/%y"))
    @condition_2 = create(:condition, date: Date.strptime("12/25/2017", "%m/%e/%y"))
    @trip1 = create(:trip, duration: 10, start_station_id: @station1.id, end_station_id: @station1.id, start_date: Date.strptime("03/21/2017", "%m/%e/%y"))#, condition: @condition2)
    @trip2 = create(:trip, duration: 20, zip_code: 95113, bike_id: @trip1.bike_id, start_station_id: @station1.id, end_station_id: @station2.id, start_date: Date.strptime("03/21/2017", "%m/%e/%y"))#, condition: @condition1)
    @trip3 = create(:trip, duration: 3, bike_id: 10, subscription_type: "Customer", zip_code: 94041, start_station_id: @station1.id, end_station_id: @station2.id, start_date: Date.strptime("12/25/2017", "%m/%e/%y"))#, condition: @condition1)
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
      # I see Month by Month breakdown of number of rides with subtotals for each year,
      # needs to be tweaked
      expect(page).to have_content("Total Rides By Month")
      expect(page).to have_content("3")
    end

    it "shows user types with number and percentage" do
      visit trips_dashboard_path

      expect(page).to have_content("2 Subscribers make up 66.67% of Total Users")
      expect(page).to have_content("1 Customers make up 33.33% of Total Users ")
    end

    it "shows the highest trip date with number of trips" do
      visit trips_dashboard_path

      expect(page).to have_content("Busiest Day: 2 rides on 2020-03-21")
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

      expect(page).to have_content("High Temperature: 105.0")
    end

    it "shows the weather for the slowest day" do
      visit trips_dashboard_path

      expect(page).to have_content("Mean Precipitation: 0.0")
    end
  end
end
