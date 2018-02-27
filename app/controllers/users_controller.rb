class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/dashboard'
    else
      render :new
    end
  end

  def dashboard
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/dashboard'
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :city, :state, :zip_code, :email, :password)
    end

end
