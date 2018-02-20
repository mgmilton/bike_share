require 'csv'
require 'date'
require 'time'


def cities
  {"San Francisco" => 91407,
   "San Jose" => 95113,
   "Redwood City" => 94063,
   "Mountain View" => 94041,
   "Palo Alto" => 94301}
end

def find_zip_code(zipcode)
   if cities.values.include?(zipcode.to_i)
     zipcode.to_i
   else
     cities["San Francisco"]
   end
end

OPTIONS = {headers: true, header_converters: :symbol}

CSV.foreach "data/weather.csv", OPTIONS do |row|
  Condition.create(id:                    row[:id],
                   date:                  Date.strptime(row[:date], '%m/%d/%y'),
                   max_temperature:       row[:max_temperature_f],
                   mean_temperature:      row[:mean_temperature_f],
                   min_temperature:       row[:min_temperature_f],
                   mean_humidity:         row[:mean_humidity],
                   mean_visibility:       row[:mean_visibility_miles],
                   mean_wind_speed:       row[:mean_wind_speed_mph],
                   mean_precipitation:    row[:mean_precipitation],
                   zip_code:              find_zip_code(row[:zip_code])
                 )
end

CSV.foreach "data/station.csv", OPTIONS do |row|
  Station.create!(id:                     row[:id],
                 name:                    row[:name],
                 latitude:                row[:lat],
                 longitude:               row[:long],
                 dock_count:              row[:dock_count],
                 city:                    row[:city],
                 installation_date:       Date.strptime(row[:installation_date], '%m/%d/%y')
                )
end

CSV.foreach "data/trip.csv", OPTIONS do |row|
  Trip.create!(id:                row[:id],
               duration:          row[:duration],
               bike_id:           row[:bike_id],
               subscription_type: row[:subscription_type],
               start_station_id:  row[:start_station_id],
               start_date:        Time.strptime(row[:start_date], '%m/%d/%y %H:%M'),
               end_station_id:    row[:end_station_id],
               end_date:          Time.strptime(row[:end_date], '%m/%d/%y %H:%M'),
               zip_code:          find_zip_code(row[:zip_code])
              )
end
