require 'rails_helper'

describe Order, type: :model do
  context 'validations' do
    it { should validate_presence_of :status }
  end

  context 'relationships' do
    it { should belong_to :user }
    it { should have_many :order_items }
    it { should have_many :items }
  end
end
