require 'rails_helper'

describe OrderItem, type: :model do
  context 'relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  context 'instance methods' do
    describe '#subtotal' do
      it 'returns the subtotal of the order item' do
        item = create(:item, price: 5.00)
        order_item = create(:order_item, item: item, quantity: 3)

        expect(order_item.subtotal).to eq(15.00)
      end
    end
  end
end
