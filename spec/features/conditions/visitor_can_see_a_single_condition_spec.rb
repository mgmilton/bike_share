require "rails_helper"

describe "As a visitor" do
  describe "When I visit the conditions index" do
    it "displays all the information for all the conditions" do
      c1 = create(:condition)
