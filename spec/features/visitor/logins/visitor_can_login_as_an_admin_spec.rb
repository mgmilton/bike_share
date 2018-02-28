require "rails_helper"

describe "As an admin" do
  describe "when he or she visits /" do
    it "he or she can login as an admin" do
      admin = create(:admin)

      visit '/login'

      within(".card") do
        fill_in "email", with: admin.email
        fill_in "password", with: admin.password

        click_on "Log In"
      end

      expect(page).to have_content("Logged in as Admin User: #{admin.name}")
      expect(page).to have_content("Email: #{admin.email}")
      expect(page).to have_content("Account Created: #{admin.created_at}")
      expect(page).to_not have_content("Log In")
      expect(page).to have_content("Log Out")
    end
  end
end
