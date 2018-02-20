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
  before_validation :set_zip_code, :set_condition

  def set_condition
    self.condition = Condition.find_by(zip_code: self.zip_code, date: self.start_date)
  end

  def set_zip_code
    self.zip_code = Station.find(self.start_station_id).zip_code
  end

  def start_station
    Station.find(start_station_id)
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
end
