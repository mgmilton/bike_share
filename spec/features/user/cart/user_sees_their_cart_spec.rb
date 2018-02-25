require "rails_helper"

describe "as a user" do
  before :each do
    user = create(:user)
    @item1 = create(:item, title: "item1")
    @item2 = create(:item, title: "item2")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  describe "when i visit /cart" do
    it "shows an image, title, description and price for each item in my cart" do
      visit bike_shop_path

      within(".item_#{@item1.id}") do
        click_on "Add Item"
      end

      within(".item_#{@item2.id}") do
        click_on "Add Item"
      end

      visit '/cart'

      # expect(page).to have_xpath("//img[contains(@src,'#{@item1.image.url}')]")
      # expect(page).to have_xpath("//img[contains(@src,'#{@item2.image.url}')]")
      expect(page).to have_content(@item1.title)
      expect(page).to have_content(@item2.title)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item2.description)
      expect(page).to have_content(@item1.price)
      expect(page).to have_content(@item2.price)
    end

    it "shows subtotal and quantity of each item" do
      visit bike_shop_path

      within(".item_#{@item1.id}") do
        click_on "Add Item"
      end

      within(".item_#{@item1.id}") do
        click_on "Add Item"
      end

      within(".item_#{@item2.id}") do
        click_on "Add Item"
      end

      visit '/cart'

      expect(page).to have_content("(2) item1 - $40.0 ")
      expect(page).to have_content("(1) item2 - $20.0 ")
      expect(page).to have_content("Total: $60")
    end
  end
end
