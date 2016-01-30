class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to item_path(@item)
    else
      flash[:notice] = "We could not save your treasure. Try again, matey!"
      redirect_to new_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def available_items_show
    @swipe = Swipe.new
    available_items = Item.available(current_user)
    if !available_items.empty?
      @item = available_items.shuffle.sample
    else
      flash[:notice] = "You're out of swipes for the day. Check back tomorrow!"
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end
end
