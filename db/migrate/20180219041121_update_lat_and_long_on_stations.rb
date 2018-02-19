class UpdateLatAndLongOnStations < ActiveRecord::Migration[5.1]
  def change
    remove_column :stations, :latitude, :decimal
    remove_column :stations, :longitude, :decimal
    add_column :stations, :latitude, :decimal, :precision => 15, :scale => 10
    add_column :stations, :longitude, :decimal, :precision => 15, :scale => 10
  end
end
