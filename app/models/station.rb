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

  has_many :trips, dependent: :nullify
  scope :started_at, ->(date) { where('start_date')}
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
    id = trips.group(:end_station_id).order('count_all').count.keys.last
    Station.find(id).name
  end

  def most_frequent_origination
    Trip.where(end_station_id: self.id)
    .joins(:station)
    .group(:station)
    .order('count_all')
    .count.keys.last.name
  end

  def busiest_date
    trips.group(:start_date).order('count_all').count.keys.last
  end

  def most_frequent_zip_code
    trips.group(:zip_code).order('count_all').count.keys.last
  end

  def most_frequent_bike_id
    trips.group(:bike_id).order('count_all').count.keys.last
  end
end
