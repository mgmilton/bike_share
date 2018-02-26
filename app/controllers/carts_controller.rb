class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item = Item.find(params[:item_id])
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.contents
    flash[:success] = "You now have #{pluralize(session[:cart][@item.id.to_s], @item.title)} in your cart"
    redirect_to items_path
  end

  def remove_item
    item = Item.find(params[:item_id])
    if @cart.remove_item(params[:item_id])
      flash[:success] = "Successfully removed #{view_context.link_to("#{item.title}", item_path(item))} from your cart."
      if session[:cart][params[:item_id]] == 0
        session[:cart].delete(params[:item_id])
      end
    else
      flash[:error] = "Seomthing went wrong. Try again?"
    end
    redirect_to '/cart'
  end
end
