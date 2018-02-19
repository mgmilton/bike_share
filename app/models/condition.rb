class Condition < ApplicationRecord
  has_many :trips
  # validates_presence_of :date, :max_temperature, :mean_temperature, :min_temperature, :mean_humidity, :zip_code
<<<<<<< HEAD
  has_many :trips
  before_validation :check_zip_code

  def check_zip_code
    unless zip_codes.values.include?(self.zip_code)
      self.zip_code = zip_codes["San Francisco"]
    end
  end
=======

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
  end

  def self.max_wind_speed
    maximum(:mean_wind_speed)
  end

  def self.max_visibility
    maximum(:mean_visibility)
  end

  def self.min_visibility
    minimum(:mean_visibility)
  end

  def self.set_divisions(floor,ceiling, increment)
    ((ceiling-floor)/increment).ceil
  end

  def self.set_range(floor, ceiling, increment)
    (0..set_divisions(floor, ceiling, increment)).map do |num|
      [(floor + num * increment).round(1), (floor + (num+1) * increment).round(1)]
    end
  end

>>>>>>> adds databse relations
end
