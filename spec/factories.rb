FactoryBot.define do
  factory :condition do
    date Time.now
    max_temperature 105.0
    min_temperature 30.0
    mean_temperature 60.0
    mean_humidity 60.0
    mean_wind_speed 3.0
    mean_visibility 3.0
    mean_precipitation 0.0
    zip_code  91407
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

  factory :item do
    sequence(:title) { |n| "Item #{n}" }
    description 'Is way cool'
    price 20.00
    image 'bike-light.jpg'
  end
end
