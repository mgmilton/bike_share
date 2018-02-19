class WeatherController < ApplicationController
  def index
    @wind_range = Condition.wind_range
  end
end
