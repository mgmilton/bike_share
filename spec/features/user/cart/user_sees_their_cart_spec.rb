require "rails_helper"

describe "as a user" do
  before :each do
    @user = create(:user)
    @item1 = create(:item, title: "item1")
    @item2 = create(:item, title: "item2")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  describe "when i visit /cart" do
    it "shows an image, title, description and price for each item in my cart" do
      visit items_path

      within(".item_#{@item1.id}") do
        click_on "Add Item"
      end

      within(".item_#{@item2.id}") do
        click_on "Add Item"
      end

      visit '/cart'

      expect(page).to have_xpath("//img[contains(@src,'#{@item1.image.url}')]")
      expect(page).to have_xpath("//img[contains(@src,'#{@item2.image.url}')]")
      expect(page).to have_content(@item1.title)
      expect(page).to have_content(@item2.title)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item2.description)
      expect(page).to have_content(@item1.price)
      expect(page).to have_content(@item2.price)
    end

    it "shows subtotal and quantity of each item" do
      visit items_path

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

    it "user can remove item form cart" do
      visit items_path

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

      within(".item_#{@item2.id}") do
        click_link "Remove"
      end

      within ('.nav-cart') do
        expect(page).to have_content(2)
      end
      expect(page).to have_content("Successfully removed item2 from your cart")
      expect(page).to_not have_content("item2 - $20.0 Is way cool")
    end

    it "pluralizes accurately" do
      visit items_path

      within(".item_#{@item1.id}") do
        click_on "Add Item"
      end

      expect(page).to have_content("You now have 1 item1 in your cart")

      within(".item_#{@item1.id}") do
        click_on "Add Item"
      end

      expect(page).to have_content("You now have 2 item1s in your cart")
    end

    it "user can remove item from cart" do
      visit items_path

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

      within(".item_#{@item1.id}") do
        click_link "Remove"
      end

      expect(page).to have_content("Successfully removed item1 from your cart")
      expect(page).to have_content("(1) item1 - $20.0")
      within('.nav-cart') do
        expect(page).to have_content(2)
      end

      within(".item_#{@item1.id}") do
        click_link "Remove"
      end

      expect(page).to have_content("Successfully removed item1 from your cart")
      within('.nav-cart') do
        expect(page).to have_content(1)
      end
      expect(page).to have_content("Total: $20.0")
      expect(page).to_not have_content("(1) item1 - $20.0")
    end

    it "shows link in flash message to deleted item upon deletion" do
      visit items_path

      within(".item_#{@item1.id}") do
        click_on "Add Item"
      end

      visit '/cart'

      within(".item_#{@item1.id}") do
        click_link "Remove"
      end

      click_link "item1"

      expect(current_path).to eq("/bike-shop/#{@item1.id}")
    end
  end
end
