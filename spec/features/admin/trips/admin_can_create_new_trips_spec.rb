require "rails_helper"

describe "ad as admin" do
  describe "when i visit the new trip path" do
    it "shows a form i can complete to create a new trip" do
      admin = create(:admin)
      station = create(:station, name: "Test Station")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_trip_path

      fill_in "Duration", with: 21
      fill_in "Bike", with: 99
      fill_in "Start date", with: Date.today
      fill_in "End date", with: Date.today
      fill_in "End station", with: 36
      fill_in "Subscription type", with: "Subscriber"
      click_on "Create Trip"

      expect(current_path).to eq("/trips/#{Trip.last.id}")
      expect(page).to have_content("Trip Successfully Saved")
      expect(page).to have_content("Trip Details")
      expect(page).to have_content("Duration: 21")
      expect(page).to have_content("Bike used: 99")
      expect(page).to have_content("Start date: #{Date.today}")
      expect(page).to have_content("Start station: 1")
      expect(page).to have_content("End date: #{Date.today}")
      expect(page).to have_content("End station: 36")
      expect(page).to have_content("Subscription type: Subscriber")
      expect(page).to have_content("Zip code: 91407")
    end
  end
end
