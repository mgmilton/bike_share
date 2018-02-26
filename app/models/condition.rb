class Condition < ApplicationRecord
  has_many :trips, dependent: :destroy
  before_validation :check_zip_code

  def check_zip_code
    unless zip_codes.values.include?(self.zip_code)
      self.zip_code = zip_codes["San Francisco"]
    end
  end

  def self.set_divisions(floor, ceiling, increment)
    ((ceiling-floor)/increment).ceil
  end

  def self.set_range(floor, ceiling, increment)
    (0..set_divisions(floor, ceiling, increment)).map do |num|
      [(floor + num * increment).round(1), (floor + (num+1) * increment).round(1)]
    end
  end

  def self.temperature_range
    min = minimum(:max_temperature)
    max = maximum(:max_temperature)
    set_range(min, max, 10)
  end

  def self.precipitation_range
    min = minimum(:mean_precipitation)
    max = maximum(:mean_precipitation)
    set_range(min, max, 0.5)
  end

  def self.wind_range
    min = minimum(:mean_wind_speed)
    max = maximum(:mean_wind_speed)
    set_range(min, max, 4)
  end

  def self.visibility_range
    min = minimum(:mean_visibility)
    max = maximum(:mean_visibility)
    set_range(min, max, 4)
  end

  def self.rides_by_temperature_range(floor, ceiling)
    where("max_temperature > #{floor} AND max_temperature <= #{ceiling}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.rides_by_precipitation_range(floor, ceiling)
    where("mean_precipitation > #{floor} AND mean_precipitation <= #{ceiling}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.rides_by_wind_range(floor, ceiling)
    where("mean_wind_speed > #{floor} AND mean_wind_speed <= #{ceiling}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.rides_by_visibility_range(floor, ceiling)
    where("mean_visibility > #{floor} AND mean_visibility <= #{ceiling}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.min(ride_range)
    return 0 if ride_range.empty?
    ride_range.last
  end

  def self.max(ride_range)
    return 0 if ride_range.empty?
    ride_range.first
  end

  def self.average(ride_range)
    return 0 if ride_range.empty?
    (ride_range.sum)/(ride_range.count)
  end

  def self.rides_by_temperature
    temperature_range.reduce({}) do |result, (min, max)|
      rides = rides_by_temperature_range(min, max)
      result["#{min} - #{max}"] = {"Lowest"=> Condition.min(rides), "Highest" => Condition.max(rides), "Average" => Condition.average(rides)}
      result
    end
  end

  def self.rides_by_precipitation
    precipitation_range.reduce({}) do |result, (min, max)|
      rides = rides_by_precipitation_range(min, max)
      result["#{min} - #{max}"] = {"Lowest"=> Condition.min(rides), "Highest" => Condition.max(rides), "Average" => Condition.average(rides)}
      result
    end
  end

  def self.rides_by_wind
    wind_range.reduce({}) do |result, (min, max)|
      rides = rides_by_wind_range(min, max)
      result["#{min} - #{max}"] = {"Lowest"=> Condition.min(rides), "Highest" => Condition.max(rides), "Average" => Condition.average(rides)}
      result
    end
  end

  def self.rides_by_visibility
    visibility_range.reduce({}) do |result, (min, max)|
      rides = rides_by_visibility_range(min, max)
      result["#{min} - #{max}"] = {"Lowest"=> Condition.min(rides), "Highest" => Condition.max(rides), "Average" => Condition.average(rides)}
      result
    end
  end
end
