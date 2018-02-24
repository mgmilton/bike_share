require "rails_helper"

describe "as a user" do
  before :each do
    @user = create(:user)
    @item1 = create(:item, title: "item1")
    @item2 = create(:item, title: "item2")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  describe "when i visit /dashboard" do
    describe "and i click on one of my orders" do
      it "should have path /orders/:id" do
        visit "bike-shop"

        within(".item_#{@item1.id}") do
          click_on "Add Item"
        end

        expect(current_path).to eq(bike_shop_path)

        visit "/dashboard"

      end
    end
  end
end
# I see the bike accessories that I ordered broken down by subtotal and quantity,
# I see the total for this order,
# I see the status of this order (ordered, completed, paid, cancelled)
# I see the date/time that the order was submitted,
# I do not see the order of another user.
#
# If the order was completed or cancelled,
# I see a timestamp when the action took place.
