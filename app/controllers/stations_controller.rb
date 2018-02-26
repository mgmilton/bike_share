class StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.friendly.find(params[:name])
  end

  def dashboard
    @stations = Station.all
  end

  private
    def require_user
      render file: "public/404" unless session[:current_user] == current_user
    end
end
