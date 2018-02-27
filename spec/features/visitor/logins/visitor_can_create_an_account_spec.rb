require "rails_helper"

describe "As a visitor" do
  describe "when I visit the root" do
    it "he or she can create a user account" do

      visit '/'

      click_link "Sign Up"

      expect(current_path).to eq(new_user_path)

      fill_in "user[first_name]", with: "Tom"
      fill_in "user[last_name]", with: "Joad"
      fill_in "user[address]", with: "4743 Mountain Road"
      fill_in "user[city]", with: "Nederland"
      fill_in "user[state]", with: "Colorado"
      fill_in "user[zip_code]", with: "91407"
      fill_in "user[email]", with: "tomjoad@socialism.com"
      fill_in "user[password]", with: "test"

      click_on "Create User"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as Tom Joad")
      expect(page).to_not have_button("Log In")
      expect(page).to have_button("Log Out")
    end
  end
end
