require "rails_helper"

describe "As a visitor" do
  describe "when I visit the root" do
    it "he or she can login" do
      user = create(:user)

      visit '/'

      fill_in "email", with: user.email
      fill_in "password", with: user.password


      click_on "Log In"

      expect(page).to have_content("Logged in as #{user.name}")
      expect(page).to have_content("Email: #{user.email}")
      expect(page).to have_content("Account Created: #{user.created_at}")
      expect(page).to_not have_content("Login")
<<<<<<< HEAD:spec/features/visitor/logins/visitor_can_login_as_a_user_spec.rb
=======
      expect(page).to have_content("Log Out")
>>>>>>> resolves the merge conflicts:spec/features/visitor/logins/visitor_can_login_as_a_user_spec.rb
    end
  end
end
