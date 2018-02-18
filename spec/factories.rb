FactoryBot.define do
  factory :condition do
    sequence(:date) {|n| "#{n}/#{n}/#{n}"}
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
end
