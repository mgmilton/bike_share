class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.integer :dock_count
      t.string :city
      t.date :installation_date
      t.decimal :latitude, limit: 8
      t.decimal :longitude, limit: 8
    end
  end
end
