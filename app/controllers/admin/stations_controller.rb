class Admin::StationsController < Admin::BaseController
  before_action :set_station, except: [:new, :create]

  def edit
    @station = Station.friendly.find(params[:name])
  end

  def update
    @station = Station.friendly.find(params[:name])
    @station.update(station_params)
    if @station.save
      flash[:success] = "#{@station.name} updated succesfully"
      redirect_to station_path(@station)
    else
      render :edit
    end
  end

  def destroy
    if @station.destroy
      flash[:success] = "#{@station.name} deleted succesfully"
    end
    redirect_to stations_path
  end

  def new
    @station = Station.new
  end

  def create
    station = Station.new(station_params)
    if station.save
      flash[:success] = "#{station.name} created succesfully"
      redirect_to station_path(station)
    else
      render :new
    end
  end

  private
    def station_params
      params.require(:station).permit(:name, :dock_count, :city, :installation_date, :latitude, :longitude)
    end

    def set_station
      @station = Station.friendly.find(params[:name])
    end
end
