class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||=Hash.new(0)
  end

  def total_count
    @contents.sum
  end

  def add_item
    @contents[item_id] += 1
  end

  def remove_item
    @contents[item_id] -= 1
  end

  def count_of
    @contents[item_id].to_i
  end
end
