class Admin::ConditionsController < Admin::BaseController
  before_action :set_condition, only: [:edit, :update, :destroy]

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      flash[:success] = "Condition was created."
      redirect_to condition_path(@condition)
    else
      flash[:error] = "Something went wrong. Try again?"
      render :new
    end
  end

  def edit

  end

  def update
    if @condition.update(condition_params)
      flash[:success] = "Condition was updated."
      redirect_to condition_path(@condition)
    else
      flash[:error] = 'Something went wrong. Try again?'
      render :edit
    end
  end

  def destroy
    if @condition.destroy
      flash[:success] = "Condition was deleted."
      redirect_to conditions_path
    else
      flash[:error] = "Something went wrong. Try again?"
      render conditions_path
    end
  end

  private

    def condition_params
      params.require(:condition).permit(:date, :max_temperature, :mean_temperature, :min_temperature, :mean_humidity, :mean_visibility, :mean_wind_speed, :mean_precipitation, :zip_code)
    end

    def set_condition
      @condition = Condition.find(params[:id])
    end
end
