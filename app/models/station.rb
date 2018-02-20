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

  def zip_codes
    {"San Francisco" => 91407,
     "San Jose" => 95113,
     "Redwood City" => 94063,
     "Mountain View" => 94041,
     "Palo Alto" => 94301}
  end

  def format_date
    installation_date.strftime('%B %d, %Y')
  end

  def self.average_bikes
    average(:dock_count)

  def zip_code
    zip_codes[self.city]
  end
end
