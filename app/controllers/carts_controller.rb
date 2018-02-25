class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item = Item.find(params[:item_id])
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.contents
    flash[:success] = "You now have #{pluralize(session[:cart][@item.id.to_s], @item.title)} in your cart"
    redirect_to bike_shop_path
  end

  def destroy
    item = Item.find(params[:item_id])
    @cart.contents[item.id].destroy
    flash[:notice] = "Successfully removed #{@item.title} from your cart"
    redirect_to '/carts'
  end
end
