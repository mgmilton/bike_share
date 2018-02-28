class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged In"
      if user.admin?
        redirect_to admin_orders_path
      else
        redirect_to '/dashboard'
      end
    else
      flash[:danger] = "Something went wrong. Try again?"
      redirect_to root_path
    end
  end


  def destroy
    session.destroy
    flash[:success] = "Successfully Logged Out"
    redirect_to root_path
  end

end
