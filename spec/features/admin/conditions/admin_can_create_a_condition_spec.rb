require "rails_helper"

context "As an admin" do
  describe "When I visit the conditions/new" do
    before(:each) do
      @admin = create(:admin, role: "admin")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    scenario "I can create a new condition" do
      visit new_admin_condition_path

      fill_in "condition[date]", with: "2/3/2018"
      fill_in "condition[max_temperature]", with: "20"
      fill_in "condition[min_temperature]", with: "3"
      fill_in "condition[mean_temperature]", with: "10"
      fill_in "condition[mean_humidity]", with: "0"
      fill_in "condition[mean_visibility]", with: "2"
      fill_in "condition[mean_wind_speed]", with: "10"
      fill_in "condition[mean_precipitation]", with: "0"
      fill_in "condition[zip_code]", with: "91407"

      click_on "Create Condition"

      expect(current_path).to eq("/conditions/#{Condition.last.id}")
      expect(page).to have_content("20")
      expect(page).to have_content("3")
      expect(page).to have_content("10")
      expect(page).to have_content("0")
      expect(page).to have_content("2")
      expect(page).to have_content("10")
      expect(page).to have_content("91407")
    end
  end
end
