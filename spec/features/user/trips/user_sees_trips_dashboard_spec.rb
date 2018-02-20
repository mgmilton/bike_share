require "rails_helper"

describe "as a registered user or admin" do
  before :each do
    @admin = create(:admin)
    @user = create(:user)
    @trip1 = create(:trip, duration: 10)
    @trip2 = create(:trip, duration: 20, zip_code: 95113)
    @trip3 = create(:trip, duration: 3, bike_id: 10, subscription_type: "Customer", zip_code: 94041)
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

      expect(page).to have_content("Busiest Day: 3 rides on 2018-02-20")
      expect(page).to have_content("Slowest Day: 3 rides on 2018-02-20")
    end
  end
end



# I see the Station with the most rides as a starting place,
# I see the Station with the most rides as an ending place,
