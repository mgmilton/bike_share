class Condition < ApplicationRecord
  # validates_presence_of :date, :max_temperature, :mean_temperature, :min_temperature, :mean_humidity, :zip_code
  has_many :trips
  before_validation :check_zip_code

  def zip_codes
    [91407, 95113, 94063, 94041, 94301]
  end

  def check_zip_code
    self.zip_code = zip_codes.first unless zip_codes.include?(self.zip_code)
  end
end
