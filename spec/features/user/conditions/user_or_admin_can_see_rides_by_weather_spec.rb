require "rails_helper"

describe "As a registered user and admin" do
  describe "When he or she visits the /weather-dashbord" do
    it "displays the breakdown of rides by weather conditions" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      conditions = create_list(:condition, 80, max_temperature: [70..80].sample, min_temperature: [68..70].sample, mean_temperature: [70..72].sample, mean_humidity: [55..57].sample, mean_wind_speed: [2..2.1].sample)
      condition_ids = conditions.pluck(:id)
      trips = create_list(:trip, 80)
        trips.map do |trip|
          trip.update(condition_id: condition_ids.sample)
        end

      visit "/weather-dashboard"


      expect(page).to have_content("Amount of Bike Rides when High Temperature was between 0.0 - 10.0 (F)")
      expect(page).to have_content("Amount of Bike Rides when Precipitation was between 0.0 - 0.5 (Inches)")
      expect(page).to have_content("Amount of Bike Rides when Wind Speed was between 0.0 - 4.0 (MPH)")
      expect(page).to have_content("Amount of Bike Rides when Visibility was between 3.0 - 7.0 (Miles)")
    end
  end
end
