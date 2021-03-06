require "rails_helper"

describe "As a visitor" do
  describe "when I visit the root" do
    it "he or she can login" do
      user = create(:user)

      visit '/login'

      within(".card") do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password

        click_on "Log In"
      end

      expect(page).to have_content("Logged in as #{user.name}")
      expect(page).to have_content("Email: #{user.email}")
      expect(page).to have_content("Account Created: #{user.created_at}")
      expect(page).to_not have_content("Login")
      expect(page).to have_content("Log Out")
    end
  end
end
