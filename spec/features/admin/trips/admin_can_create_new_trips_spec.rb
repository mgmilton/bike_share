require "rails_helper"

describe "ad as admin" do
  describe "when i visit the new trip path" do
    it "shows a form i can complete to vcreate a new trip" do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_trip_path

      fill_in "Duration", with: 21
      fill_in "Start date", with: 12252017
    end
  end
end



  # As a admin,
  # When I visit '/trips/new',
  # I fill in a form with all trip attributes,
  # When I click "Create Trip",
  # I am directed to that trip's show page.
  # I also see a flash message that I have created that trip.
