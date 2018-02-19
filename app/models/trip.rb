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
    group(:bike_id).order('count_id DESC').limit(1).count(:id)
  end

  def self.least_ridden
    group(:bike_id).order('count_id').limit(1).count(:id)
  end
end
