class Condition < ApplicationRecord
  validates_presence_of :date, :max_temperature, :mean_temperature, :min_temperature, :mean_humidity, :zip_code
end
