require "rails_helper"

describe "as a visitor" do
  describe "when i visit the trip dashboard" do
    it "i see a 404 page" do
      visit trips_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
