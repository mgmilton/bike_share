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

  has_many :trips

  def self.average_bikes
    average(:dock_count)
  end

  def zip_code
    zip_codes[self.city]
  end
end
