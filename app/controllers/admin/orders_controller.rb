class Admin::OrdersController < Admin::BaseController
  def index
    if params[:status]
      @orders = Order.where(status: params[:status])
    else
      @orders = Order.all
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    if @order.save
      flash[:success] = "Order #{@order.id} #{@order.status}"
      redirect_to admin_orders_path
    else
      render :index
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
