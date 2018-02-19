require 'csv'
require 'date'

def format_zip_code(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def format_date(date)
  Date.strptime(date, '%m/%d/%y')
end

def format_date_time(datetime)
  DateTime.strptime(datetime, '%m/%d/%y %H:%m')
end

OPTIONS = {headers: true, header_converters: :symbol}

conditions.foreach "data/weather.csv", OPTIONS do |row|
  Condition.create(id:                    row[:id],
                   date:                  format_date(row[:date]),
                   max_temperature:       row[:max_temperature_f],
                   mean_temperature:      row[:mean_temperature_f],
                   min_temperature:       row[:min_temperature_f],
                   mean_humidity:         row[:mean_humidity],
                   mean_visibility:       row[:mean_visibility_miles],
                   mean_wind_speed:       row[:mean_wind_speed_mph],
                   mean_precipitation:    row[:mean_precipitation],
                   zip_code:              format_zip_code(row[:zip_code])
                 )
end

stations.foreach "data/station.csv", OPTIONS do |row|
  Station.create!(id:                     row[:id],
                 name:                    row[:name],
                 latitude:                row[:lat],
                 longitude:               row[:long],
                 dock_count:              row[:dock_count],
                 city:                    row[:city],
                 installation_date:       format_date(row[:installation_date])
                )
end

trips.foreach "data/trip.csv", OPTIONS do |row|
  trip_start = TripStart.create!(
                                  start_date: format_date_time(row[:start_date]),
                                  start_station_id: row[:start_station_id],
                                )
  trip_end = TripEnd.create!(
                              end_date: format_date_time(row[:end_date]),
                              end_station_id: row[:end_station_id],
                            )
  Trip.create!(id:               row[:id],
              duration:          row[:duration],
              trip_start_id:     trip_start.id,
              trip_end_id:       trip_end.id,
              bike_id:           row[:bike_id],
              subscription_type: row[:subscription_type],
              zip_code:          trip_start.station.city
            )
end
