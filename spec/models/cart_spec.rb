require 'rails_helper'

describe Cart, type: :model do
  before(:each) do
    @cart = Cart.new({"1" => 2, "2" => 3})
  end

  describe "#total_count" do
    it "can calculate the total number of items cart holds" do
      expect(@cart.total_count).to eq(5)
    end
  end

  # describe "#add_item" do
  #   it "adds an item to its contents" do
  #     @cart.add_item
  #     @cart.add_item
  #
  #     expect(@cart.contents).to eq({"1" => 3, "2" => 4})
  #   end
  # end
  describe "#remove_item" do
    it "removes an item from its contents" do
      @cart.remove_item(1)
      @cart.remove_item(2)
      expect(@cart.contents).to eq({"1" => 1, "2" => 2})
    end
  end


  #   it "handles default nil" do
  #     cart = Cart.new(nil)
  #     expect(cart.contents).to eq({})
  #
  #     cart.add_item("1")
  #     expect(cart.contents).to eq("1" => 1)
  #   end
  # end

  describe "#count_of" do
    it "returns a count of a particular movie" do
      expect(@cart.count_of(1)).to eq(2)
      expect(@cart.count_of(2)).to eq(3)
    end
  end
end
