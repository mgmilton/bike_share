class StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    binding.pry
    @station = Station.friendly.find(params[:name])
  end
end
