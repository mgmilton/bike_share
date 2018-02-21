require "rails_helper"

context "As an admin" do
  describe "When I visit the conditions index" do
    before(:each) do
      @admin = create(:admin, role: "admin")
      @condition = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    scenario "I can delete a condition" do
      visit conditions_path

      click_link "Delete"

      expect(current_path).to eq(conditions_path)
      expect(page).to_not have_content(@condition.max_temperature)
      expect(page).to_not have_content(@condition.mean_temperature)
      expect(page).to_not have_content(@condition.mean_wind_speed)
      expect(page).to have_content("Condition was deleted.")
    end
  end
end
