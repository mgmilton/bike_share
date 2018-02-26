class StationsController < ApplicationController
  before_action :require_user, only: :dashboard
  def index
    @stations = Station.all
  end

  def show
    @station = Station.friendly.find(params[:name])
  end

  def dashboard
    @stations = Station.all
  end
end
