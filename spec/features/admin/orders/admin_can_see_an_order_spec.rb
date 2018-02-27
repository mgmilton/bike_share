require 'rails_helper'

context 'As an admin' do
  describe 'When I visit an individual order page' do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      @order = create(:order)
    end
    scenario "In addition to what a user sees, I also see the purchaser's full name and address" do
      visit admin_order_path(@order)

      expect(page).to have_content(@order.user.full_name)
      expect(page).to have_content(@order.user.address)
    end
  end
end
#
  # I see the purchaser's full name and address,
# I see the item's name, which is linked to the item page.
# I see the quantity in this order.
# I see the line item subtotal,
# I see the total for the order,
# I also see the status for the order
