require 'rails_helper'

context 'As an admin' do
  describe "When I visit '/admin/dashboard" do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      @orders = create_list(:order, 5)
    end
    scenario 'I see a list of all orders and a link for each order' do
      visit 'admin/dashboard'

      @orders.each do |order|
        expect(page).to have_link(order.id)
      end
    end
  end
end
#
# I see the total number of orders for each status ("Ordered", "Paid", "Cancelled", "Completed"),
# I can filter orders to display by each status type ("Ordered", "Paid", "Cancelled", "Completed"),
# I have links to transition between statuses
#
# I can click on "cancel" on individual orders which are "paid" or "ordered"
# I can click on "mark as paid" on orders that are "ordered"
# I can click on "mark as completed" on orders that are "paid"
