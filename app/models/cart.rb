class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||=Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def remove_item(item_id)
    @contents[item_id] -= 1
  end

  def count_of(item_id)
    @contents[item_id].to_i
  end

  def total_cost
    @contents.sum do |item, quantity|
      item = Item.find(item.to_i)
      item.price * quantity
    end
  end
end
