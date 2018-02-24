class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper


  def index
    @cart
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.contents
    flash[:success] = "You now have #{pluralize(session[:cart][item.id.to_s], item.title)} in your cart"
    redirect_to items_path(params[:item_id])
  end

  def destroy
    item = Item.find(params[:item_id])
    @cart.contents[item.id].destroy
    flash[:notice] = "Successfully removed #{@item.title} from your cart"
    redirect_to '/carts'
  end
end
