require "rails_helper"

describe "as an admin" do
  describe "when i visit the new trip path" do
    it "shows a form i can complete to create a new trip" do
      admin = create(:admin)
      station = create(:station, name: "Test Station")
      station = create(:station, name: "Another Test Station")
      trip = create(:trip, subscription_type: "Customer")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      
      visit new_admin_trip_path
      fill_in "Duration", with: 21
      fill_in "Bike", with: 99
      fill_in "Start date", with: Date.today

      select("Test Station", from: "Start station")
      select("Another Test Station", from: "End station")
      fill_in "End date", with: Date.today
      select("Customer", from: "Subscription Type")
      click_on "Create Trip"


      expect(current_path).to eq("/trips/#{Trip.last.id}")
      expect(page).to have_content("Trip Successfully Saved")
      expect(page).to have_content("Trip Details")
      expect(page).to have_content("Duration: 21")
      expect(page).to have_content("Bike used: 99")
      expect(page).to have_content("Start station: Test Station")
      expect(page).to have_content("Start date: #{Date.today}")
      expect(page).to have_content("End station: Another Test Station")
      expect(page).to have_content("End date: #{Date.today}")
      expect(page).to have_content("Test Station")
      expect(page).to have_content("Subscription type: Customer")
      expect(page).to have_content("Zip code: 91407")
    end
  end
end
