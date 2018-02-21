class Admin::StationsController < Admin::BaseController
  before_action :set_station

  def edit
    @station = Station.friendly.find(params[:name])
  end

  def update
    @station = Station.friendly.find(params[:name])
    @station.update(station_params)
    if @station.save
      flash[:notice] = "#{@station.name} updated succesfully"
      redirect_to station_path(@station)
    else
      render :edit
    end
  end

  def destroy
    if @station.destroy
      flash[:notice] = "#{@station.name} deleted succesfully"
    end
    redirect_to stations_path
  end

  private
    def station_params
      params.require(:station).permit(:name, :dock_count, :city, :installation_date, :latitude, :longitude)
    end

    def set_station
      @station = Station.friendly.find(params[:name])
    end
end
