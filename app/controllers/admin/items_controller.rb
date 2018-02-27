class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: [:edit, :update, :show]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:success] = "#{item.title} created succesfully"
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      flash[:success] = "#{@item.title} succesfully updated"
      redirect_to admin_items_path
    else
      render :'items#index'
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :description, :price, :image, :status)
    end

    def set_item
      @item = Item.find(params[:id])
    end
end
