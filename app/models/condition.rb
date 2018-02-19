class Condition < ApplicationRecord
  has_many :trips
  before_validation :check_zip_code

  def check_zip_code
    unless zip_codes.values.include?(self.zip_code)
      self.zip_code = zip_codes["San Francisco"]
    end
  end

  def self.max_temperature
    maximum(:max_temperature)
  end

  def self.min_temperature
    minimum(:max_temperature)
  end

  def self.max_precipitation
    maximum(:mean_precipitation)
  end

  def self.min_precipitation
    minimum(:mean_precipitation)
  end

  def self.min_wind_speed
    minimum(:mean_wind_speed)

  def self.set_divisions(floor,ceiling, increment)
    ((ceiling-floor)/increment).ceil
  end

  def self.set_range(floor, ceiling, increment)
    (0..set_divisions(floor, ceiling, increment)).map do |num|
      [(floor + num * increment).round(1), (floor + (num+1) * increment).round(1)]
    end
  end

  def self.temp_range
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
end
