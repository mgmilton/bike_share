class Admin::StationsController < Admin::BaseController
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

  private
    def station_params
      params.require(:station).permit(:name, :dock_count, :city, :installation_date, :latitude, :longitude)
    end
end
