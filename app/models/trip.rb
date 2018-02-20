class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station_id,
                        :end_date,
                        :end_station_id,
                        :bike_id,
                        :subscription_type
                        # :zip_code
  belongs_to :condition, optional: true
  belongs_to :station
  before_validation :check_zip_code, :set_condition

  def set_condition
    self.condition = Condition.find_by(zip_code: self.zip_code, date: self.start_date)
  end

  def check_zip_code
    unless zip_codes.values.include?(self.zip_code)
      self.zip_code = self.station.zip_code
    end
  end
  
  def self.average_duration
    average(:duration)
  end

  def self.longest_duration
    maximum(:duration)
  end

  def self.shortest_duration
    minimum(:duration)
  end

  def self.monthly
    group("DATE_TRUNC('month', start_date)").count
  end

  def self.most_ridden
    group(:bike_id).order('bike_id DESC').limit(1).count(:id)
  end

  def self.least_ridden
    group(:bike_id).order('bike_id').limit(1).count(:id)
  end

  def self.user_types
    group(:subscription_type).order('subscription_type DESC').count(:id)
  end

  def self.busiest_day
    trips_by_day.key(highest_number_of_rides)
  end

  def self.slowest_day
    trips_by_day.key(least_number_of_rides)
  end

  def self.highest_number_of_rides
    (trips_by_day.values).max
  end

  def self.least_number_of_rides
    (trips_by_day.values).min
  end

  def self.weather_for_busiest_day
    Condition.find_by(date: busiest_day)
  end
  # <!-- <strong>Weather For Busiest Day:</strong> High Temperature: <%= @trips.weather_for_busiest_day.max_temperature %> Lowest Temperature: <%= @trips.weather_for_busiest_day.min_temperature %> Precipitation: <%= @trips.weather_for_busiest_day.mean_precipitation %><br> -->


  def self.weather_for_slowest_day
    Condition.find_by(date: slowest_day)
  end
  # <!-- <strong>Weather For Slowest Day:</strong> High Temperature: <%= @trips.weather_for_slowest_day.max_temperature %> Lowest Temperature: <%= @trips.weather_for_slowest_day.min_temperature %> Precipitation: <%= @trips.weather_for_slowest_day.mean_precipitation %><br> -->

  def self.station_with_most_starts_name
    Station.find_by(id: station_with_most_starts).name
  end

  def self.station_with_most_ends_name
    Station.find_by(id: station_with_most_ends).name
  end



  private

    def self.trips_by_day
      group("DATE(start_date)").count
    end

    def self.station_with_most_starts
      group(:start_station_id).order('count(id) DESC').count.first.first
    end

    def self.station_with_most_ends
      group(:end_station_id).order('count(id) DESC').count.first.first
    end

end
