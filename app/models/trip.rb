class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station_id,
                        :end_date,
                        :end_station_id,
                        :bike_id,
                        :subscription_type
                        # :zip_code

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
