require "rails_helper"

describe "as an admin" do
  before :each do
    @admin = create(:admin)
    @user = create(:user)
    @station1 = create(:station, name: "station 1")
    @station2 = create(:station, name: "station 2")
    @trip1 = create(:trip, duration: 10, start_station_id: @station1.id, end_station_id: @station1.id, start_date: Date.strptime("08/27/2015", "%m/%e/%y"))
    @trip2 = create(:trip, duration: 20, zip_code: 95113, bike_id: @trip1.bike_id, start_station_id: @station1.id, end_station_id: @station2.id, start_date: Date.strptime("12/25/2014", "%m/%e/%y"))
    @trip3 = create(:trip, duration: 3, bike_id: 10, subscription_type: "Customer", zip_code: 94041, start_station_id: @station1.id, end_station_id: @station2.id, start_date: Date.strptime("08/27/2015", "%m/%e/%y"))
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe "when i visit trips index" do
    it "shows a link to edit" do
      visit trips_path

      within(".trip_#{@trip1.id}") do
        click_link "Edit"
      end

      expect(current_path).to eq(edit_admin_trip_path(@trip1))

      fill_in "Duration", with: 100
      click_on "Update Trip"

      expect(page).to have_content("Trip Successfully Updated")

      visit trips_path

      expect(page).to have_content("Trip Duration: 100")
    end

    it "shows a link to delete" do
      visit trips_path

      within(".trip_#{@trip1.id}") do
        click_link "Delete"
      end

      expect(page).to_not have_content("Trip Duration: 10")
    end
  end
end
