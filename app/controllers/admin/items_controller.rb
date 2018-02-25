class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find_by(slug: params[:title])
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
    item = Item.find(params[:title])
    item.update(item_params)
    if item.save
      flash[:notice] = "#{item.title} succesfully updated"
      redirect_to admin_items_path
    else
      render :'items#index'
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :description, :price, :image, :status)
    end
end
