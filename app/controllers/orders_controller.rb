class OrdersController < ApplicationController
before_action :require_user

  def create
    @order = current_user.orders.create(total: @cart.total_cost)
    session[:cart].each do |item_id, quantity|
      @order.order_items.create(item_id: item_id.to_i, quantity: quantity)
    end
    flash[:success] = "Your order has been successfully submitted"
    session[:cart] = nil
    redirect_to "/dashboard"
  end

  def show
    if current_admin?
      @order = Order.find(params[:id])
    elsif current_user.orders.ids.include?(params[:id].to_i)
      @order = Order.find(params[:id])
    else
      render "/session"
    end
  end
end
