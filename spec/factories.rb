FactoryBot.define do
  factory :condition do
    sequence(:date) { |n| "n/n/n" }
    sequence(:max_temperature) {|n| "Max Temp #{n}"}
    sequence(:mean_temperature) {|n| "Mean Temp #{n}"}
    sequence(:min_temperature) {|n| "Min Temp #{n}"}
    sequence(:mean_humidity) {|n| "Mean Humidity #{n}"}
    sequence(:mean_visibility) {|n| "Mean Visibility #{n}"}
    sequence(:mean_wind_speed) {|n| "Mean Wind Speed #{n}"}
    sequence(:mean_precipitation) {|n| "Mean Precipitation#{n}"}
    sequence(:zip_code) {|n| "Zip Code #{n}"}
  end

  factory :user do
    sequence(:name) {|n| "Name #{n}"}
    sequence(:email) {|n| "Email#{n}@gmail.com"}
    sequence(:password) {|n| "Password#{n}"}
  end

  factory :admin, class: User do
    name "Admin"
    email "admin@gmail.com"
    password "Admin"
    role 1
  end

  factory :trip do
    duration 10
    start_date Time.now
    start_station_id 1
    end_date Time.now
    end_station_id 1
    sequence(:bike_id) { |n| n }
    subscription_type "Subscriber"
    zip_code 91407
    station
  end

  factory :station do
    sequence(:name) { |n| "Station #{n}" }
    dock_count 25
    city 'San Francisco'
    installation_date Date.new(2013,8,20)
    latitude 	37.789756
    longitude (-122.39464299999999)
  end
end
