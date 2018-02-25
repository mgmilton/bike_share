class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged In"
      redirect_to "/dashboard"
    else
      flash[:error] = "Something went wrong. Try again?"
      redirect_to root_path
    end
  end


  def destroy
    session.destroy
    flash[:success] = "Successfully Logged Out"
    redirect_to root_path
  end
end
