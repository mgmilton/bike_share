class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    item = Item.find(params[:item_id])
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.contents
    flash[:success] = "You now have #{pluralize(session[:cart][item.id.to_s], item.title)} in your cart"
    redirect_to items_path(params[:item_id])
  end  
end
