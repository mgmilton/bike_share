class CreateConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :conditions do |t|
      t.date :date
      t.decimal :max_temperature 
      t.decimal :mean_temperature
      t.decimal :min_temperature
      t.decimal :mean_humidity
      t.decimal :mean_visibility
      t.decimal :mean_wind_speed
      t.decimal :mean_precipitation
      t.integer :zip_code
    end
  end
end
