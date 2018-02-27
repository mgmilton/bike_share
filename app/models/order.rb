class Order < ApplicationRecord
  validates_presence_of :status
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  enum status: %w(Ordered Completed Paid Canceled)
  scope :ordered, -> { where(status: "Ordered") }
  scope :paid, -> { where(status: "Paid") }
  scope :canceled, -> { where(status: "Canceled") }
  scope :completed, -> { where(status: "Completed") }

  def convert_time(datetime)
    time = datetime.in_time_zone("Mountain Time (US & Canada)")
    time.strftime("%m/%d/%Y %H:%M %Z")
  end
end
