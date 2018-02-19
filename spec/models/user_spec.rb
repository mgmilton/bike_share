require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it "presence of email" do
      user = User.new(password: "test")

      expect(user).to_not be_valid
    end

    it "uniqueness of email" do
      u1 = User.create(email: "ebwhite@grammer.com", password: "test")
      u2 = User.new(email: "ebwhite@grammer.com", password: "test")

      expect(u2).to_not be_valid
    end
  end

  describe "roles" do
    it "he or she can create user as an admin" do
      user = create(:user, role: 1)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end

    it "he or she creates a default user" do
      user = create(:user, role: 0)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
  end
end
