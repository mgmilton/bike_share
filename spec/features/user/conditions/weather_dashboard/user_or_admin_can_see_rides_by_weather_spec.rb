require "rails_helper"

describe "As a registered user and admin" do
  describe "When he or she visits the /weather-dashbord" do
    it "displays the breakdown of rides by weather conditions" do
      create_list(:condition, 10)
      visit "/weather-dashboard"
  
      expect(page).to have_content("Amount of Bike Rides when High Temperature was between")
      expect(page).to have_content("Amount of Bike Rides when Precipitation was between")
      expect(page).to have_content("Amount of Bike Rides when Wind Speed was between")
      expect(page).to have_content("Amount of Bike Rides when Visibility was between")
    end
  end
end
