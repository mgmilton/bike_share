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
    where(dock_count: most_bikes_available).pluck(:name)
  end

  def self.fewest_bikes_available
    minimum(:dock_count)
  end

  def self.lowest_dock_count
    where(dock_count: fewest_bikes_available).pluck(:name)
  end

  def self.most_recent
    order(:installation_date).last.name
  end

  def self.oldest
    order(:installation_date).first.name
  end

  def trip_start_count
    trips.count
  end

  def trip_end_count
    Trip.where(end_station_id: self.id).count
  end

  def most_frequent_destination
    Station.find(trips.group(:end_station_id).order('count_all').count.keys.last).name
  end
end
