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

        within(".item_#{@item1.id}") do
          click_on "Add Item"
        end

        within(".item_#{@item2.id}") do
          click_on "Add Item"
        end

        expect(current_path).to eq(bike_shop_path)

        visit "/cart"

        click_link "Check Out"

        expect(page).to have_content("Your order has been successfully submitted")

        click_on "1"

        expect(page).to have_content("Cart: 0")
        expect(page).to have_content("Order 1")
        expect(page).to have_content("Order Total: $60.0 ")
        expect(page).to have_content("Date Submitted:")
        expect(page).to have_content("Date Ordered:")
        expect(page).to have_content("Order Status: Ordered")
        expect(page).to have_content("Items Ordered:")
        expect(page).to have_content("Item: item1
                                      Quantity: 2
                                      Subtotal: 40.0")
        expect(page).to have_content("Item: item2
                                      Quantity: 1
                                      Subtotal: 20.0")
      end
    end
  end
end
# If the order was completed or cancelled,
# I see a timestamp when the action took place.
