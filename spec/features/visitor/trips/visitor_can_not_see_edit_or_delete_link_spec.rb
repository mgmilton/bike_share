require "rails_helper"

describe "as visitor" do
  describe "when i visit trips index" do
    it "does not show edit or delete link" do
      visit trips_path

      expect(page).to_not have_link("Edit")
      expect(page).to_not have_link("Delete")
    end
  end
end
