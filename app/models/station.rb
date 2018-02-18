class Station < ApplicationRecord
  validates_presence_of   :name,
                          :dock_count,
                          :city,
                          :installation_date,
                          :lattitude,
                          :longitude
  validates_uniqueness_of :name
end
