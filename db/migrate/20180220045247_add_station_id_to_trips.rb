class AddStationIdToTrips < ActiveRecord::Migration[5.1]
  def change
    add_reference :trips, :station, foreign_key: true
  end
end
