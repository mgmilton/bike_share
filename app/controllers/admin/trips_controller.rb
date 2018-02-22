class Admin::TripsController < Admin::BaseController
  before_action :set_trip, only: [:edit, :update, :destroy]

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.station_id = @trip.start_station_id
    if @trip.save
      flash[:success] = "Trip Successfully Saved"
      redirect_to trip_path(@trip)
    else
      flash[:error] = "Something went wrong. Try again?"
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    if @trip.update(trip_params)
      flash[:success] = "Trip Successfully Updated"
      redirect_to trip_path(@trip)
    else
      flash[:error] = 'Something went wrong. Try again?'
      render :edit
    end
  end

  def destroy
    if @trip.destroy
      flash[:success] = "Trip Successfully Deleted"
      redirect_to trips_path
    else
      flash[:error] = "Something went wrong. Try again?"
      render trips_path
    end
  end


  private

    def trip_params
      params.require(:trip).permit(:duration, :start_date, :start_station_id, :end_date, :end_station_id, :bike_id, :subscription_type, :zip_code)
    end

    def set_trip
      @trip = Trip.find(params[:id])
    end
end
