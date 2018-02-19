class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged
  validates_presence_of   :name,
                          :dock_count,
                          :city,
                          :installation_date,
                          :latitude,
                          :longitude
  validates_uniqueness_of :name
  enum city: {
    "91407" => "San Francisco",
    "95113" => "San Jose",
    "94063" => "Redwood City",
    "94041" => "Mountain View",
    "94301" => "Palo Alto"
  }
  has_many :trips

  def format_date
    installation_date.strftime('%B %d, %Y')
  end

  def self.average_bikes
    average(:dock_count)
  end
end
