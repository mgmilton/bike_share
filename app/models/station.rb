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

  def zip_code
    zip_codes[self.city]
  end

  def self.average_bikes
    average(:dock_count)
  end

  def self.most_bikes_available
    maximum(:dock_count)
  end

  def self.highest_dock_count
    where(dock_count: most_bikes_available)
  end

  def self.fewest_bikes_available
    minimum(:dock_count)
  end

  def self.lowest_dock_count
    where(dock_count: fewest_bikes_available)
  end
end
