require "rails_helper"

context "As an admin" do
  describe "When I viist the conditions index" do
    before(:each) do
      @admin = create(:user, role: "admin")
      @condition1 = create(:condition)
      @condition2 = create(:condition)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    scenario "I see all the conditions and they're info" do
      visit conditions_path

      expect(page).to have_content(@condition1.date)
      expect(page).to have_content(@condition2.date)
      expect(page).to have_content(@condition1.max_temperature)
      expect(page).to have_content(@condition2.max_temperature)
      expect(page).to have_content(@condition1.min_temperature)
      expect(page).to have_content(@condition2.min_temperature)
      expect(page).to have_content(@condition1.mean_temperature)
      expect(page).to have_content(@condition2.mean_temperature)
      expect(page).to have_content(@condition1.mean_humidity)
      expect(page).to have_content(@condition2.mean_humidity)
      expect(page).to have_content(@condition1.mean_visibility)
      expect(page).to have_content(@condition2.mean_visibility)
      expect(page).to have_content(@condition1.mean_wind_speed)
      expect(page).to have_content(@condition2.mean_wind_speed)
      expect(page).to have_content(@condition1.mean_precipitation)
      expect(page).to have_content(@condition2.mean_precipitation)
      expect(page).to have_content(@condition1.zip_code)
      expect(page).to have_content(@condition2.zip_code)
    end

    scenario "I see buttons to edit and delete the conditions" do

      visit conditions_path

      page.should have_selector(:link_or_button, "Edit")
      page.should have_selector(:link_or_button, "Delete")
    end
  end
end
