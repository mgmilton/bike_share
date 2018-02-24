class OrdersController < ApplicationController

  def create
    @order = current_user.orders.create
    session[:cart].each do |item_id, quantity|
      @order.order_items.create(item_id: item_id.to_i, quantity: quantity)
    end
    flash[:success] = "Your order has been successfully submitted"
    session[:cart] = nil
    redirect_to "/dashboard"
  end

  def show
    @order = Order.find(params[:id])
  end
end
