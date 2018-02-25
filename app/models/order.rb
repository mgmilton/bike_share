class Order < ApplicationRecord
  validates_presence_of :status
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  enum status: %w(Ordered Completed Paid Canceled)

  def convert_time(datetime)
    time = datetime.in_time_zone("Mountain Time (US & Canada)")
    time.strftime("%m/%d/%Y %H:%M %Z")
  end
end
