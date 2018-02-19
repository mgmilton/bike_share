class WeatherDashboardController < ApplicationController
  def index
    @rides_by_temp = Condition.rides_by_temperature
    @rides_by_precipitation = Condition.rides_by_precipitation
    @rides_by_wind = Condition.rides_by_wind
    @rides_by_visibility = Condition.rides_by_visibility
  end
end
