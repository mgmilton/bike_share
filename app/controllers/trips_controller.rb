class TripsController < ApplicationController

  def index
    @trips = Trip.order(:end_date).last(30)
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
