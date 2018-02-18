class Station < ApplicationRecord
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
end
