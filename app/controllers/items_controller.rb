class ItemsController < ApplicationController
  def index
    @items = Item.all #last(10) matches made ?
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

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end
end
