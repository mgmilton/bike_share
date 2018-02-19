class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :use => :slugged
  validates_presence_of   :name,
                          :dock_count,
                          :city,
                          :installation_date,
                          :latitude,
                          :longitude
  validates_uniqueness_of :name

  def format_date
    installation_date.strftime('%B %d, %Y')
  end

  def self.average_bikes
    average(:dock_count)
  end
end
