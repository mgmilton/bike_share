require 'csv'
require 'date'
require 'time'

OPTIONS = {headers: true, header_converters: :symbol}

CSV.foreach "db/fixture-data/weather.csv", OPTIONS do |row|
  Condition.create(id:                    row[:id],
                   date:                  Date.strptime(row[:date], '%m/%d/%y'),
                   max_temperature:       row[:max_temperature_f],
                   mean_temperature:      row[:mean_temperature_f],
                   min_temperature:       row[:min_temperature_f],
                   mean_humidity:         row[:mean_humidity],
                   mean_visibility:       row[:mean_visibility_miles],
                   mean_wind_speed:       row[:mean_wind_speed_mph],
                   mean_precipitation:    row[:mean_precipitation],
                   zip_code:              row[:zip_code]
                 )
end

CSV.foreach "db/fixture-data/station.csv", OPTIONS do |row|
  Station.create!(id:                     row[:id],
                 name:                    row[:name],
                 latitude:                row[:lat],
                 longitude:               row[:long],
                 dock_count:              row[:dock_count],
                 city:                    row[:city],
                 installation_date:       Date.strptime(row[:installation_date], '%m/%d/%y')
                )
end

CSV.foreach "db/fixture-data/trip.csv", OPTIONS do |row|
  Trip.create!(id:                row[:id],
               duration:          row[:duration],
               bike_id:           row[:bike_id],
               subscription_type: row[:subscription_type],
               start_station_id:  row[:start_station_id],
               start_date:        Time.strptime(row[:start_date], '%m/%d/%y'),
               end_station_id:    row[:end_station_id],
               end_date:          Time.strptime(row[:end_date], '%m/%d/%y'),
               station:           Station.find(row[:start_station_id]),
               zip_code:          row[:zip_code]
             )
end

User.create!(name: "admin", email: "admin@email.com", password: "admin", role: 1)
User.create!(name: "user", email: "user@email.com", password: "user")

Item.create!(title: "item1", description: "an aweful item", price: 10)
Item.create!(title: "item2", description: "a poor item", price: 20)
Item.create!(title: "item3", description: "a bad item", price: 30)
Item.create!(title: "item4", description: "an okay item", price: 40)
Item.create!(title: "item5", description: "an average item", price: 50)
Item.create!(title: "item6", description: "a decent item", price: 60)
Item.create!(title: "item7", description: "a good item", price: 70)
Item.create!(title: "item8", description: "a great item", price: 80)
Item.create!(title: "item9", description: "a superb item", price: 90)
Item.create!(title: "item10", description: "a fantastic item", price: 100)
Item.create!(title: "item11", description: "a legendary item", price: 110)
Item.create!(title: "item12", description: "a perfect item", price: 120)
