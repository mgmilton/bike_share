class Condition < ApplicationRecord
  # validates_presence_of :date, :max_temperature, :mean_temperature, :min_temperature, :mean_humidity, :zip_code
  has_many :trips
  before_validation :check_zip_code

  def check_zip_code
    unless zip_codes.values.include?(self.zip_code)
      self.zip_code = zip_codes["San Francisco"]
    end
  end
end
