class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:notice] = "#{item.title} created succesfully"
      redirect_to '/bike-shop'
    else
      render :new
    end
  end

  def update
    binding.pry
    item = Item.find_by(slug: params[:title])
    item.update(item_params)
    if item.save
      flash[:notice] = "#{item.title} succesfully updated"
      redirect_to bike_shop_path(item)
    else
      render :'items#index'
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :description, :price, :image)
    end
end
