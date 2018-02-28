require 'rails_helper'

context 'As an admin' do
  describe "When I visit '/admin/dashboard" do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      @orders = create_list(:order, 3)
      @completed = create_list(:order, 2, status: 1)
      @paid = create_list(:order, 4, status: 2)
      @canceled = create_list(:order, 1, status: 3)
    end
    scenario 'I see a list of all orders and a link for each order' do
      visit 'admin/dashboard'

      @orders.each do |order|
        expect(page).to have_link(order.id)
      end
    end

    scenario 'I see the total number of orders for each status ("Ordered", "Paid", "Cancelled", "Completed"),' do
      visit 'admin/dashboard'

      expect(page).to have_content("Ordered(3)")
      expect(page).to have_content("Paid(4)")
      expect(page).to have_content("Canceled(1)")
      expect(page).to have_content("Completed(2)")
    end
    scenario 'I can filter orders to display by each status type ("Ordered", "Paid", "Cancelled", "Completed"),' do
      visit 'admin/dashboard'

      select('Ordered', from: 'Status')
      click_on 'Filter'
      expect(page).to have_link(@orders.first.id)
      expect(page).to_not have_link(@completed.first.id)
      expect(page).to_not have_link(@paid.first.id)
      expect(page).to_not have_link(@completed.first.id)

      select('Canceled', from: 'Status')
      click_on 'Filter'
      expect(page).to have_link(@canceled.first.id)
      expect(page).to_not have_link(@completed.first.id)
      expect(page).to_not have_link(@paid.first.id)
    end

    scenario 'I have links to transition between statuses' do
      visit 'admin/dashboard'

      expect(page).to have_button('cancel')
      expect(page).to have_button('mark as paid')
      expect(page).to have_button('mark as completed')
    end

    scenario 'I can click on "cancel" on individual orders which are "paid" or "ordered"' do
      visit 'admin/dashboard'

      within(".order-#{@orders.first.id}") do
        expect(page).to have_content('Ordered')
      end

      within(".order-#{@orders.first.id}") do
        click_on 'cancel'
      end

      within(".order-#{@orders.first.id}") do
        expect(page).to have_content('Canceled')
      end

      within(".order-#{@paid.first.id}") do
        expect(page).to have_content('Paid')
      end

      within(".order-#{@paid.first.id}") do
        click_on 'cancel'
      end

      within(".order-#{@paid.first.id}") do
        expect(page).to have_content('Canceled')
      end
    end

    scenario 'I can click on "mark as paid" on orders that are "ordered"' do
      visit 'admin/dashboard'

      within(".order-#{@orders.first.id}") do
        expect(page).to have_content('Ordered')
      end

      within(".order-#{@orders.first.id}") do
        click_on 'mark as paid'
      end

      within(".order-#{@orders.first.id}") do
        expect(page).to have_content('Paid')
      end
    end

    scenario 'I can click on "mark as completed" on orders that are "paid"' do
      visit 'admin/dashboard'

      within(".order-#{@paid.first.id}") do
        expect(page).to have_content('Paid')
      end

      within(".order-#{@paid.first.id}") do
        click_on 'mark as completed'
      end

      within(".order-#{@paid.first.id}") do
        expect(page).to have_content('Completed')
      end
    end
  end
end
