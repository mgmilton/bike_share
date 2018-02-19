class TripsController < ApplicationController
  has_two :stations
  def index
    @trips = Trip.order(:end_date).reverse_order.offset(params[:offset]).first(30)
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
