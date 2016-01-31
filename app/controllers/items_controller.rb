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
    @item = Item.find_by(id: params[:id])
    if @item && @item.user == current_user
      @matches = @item.all_matches
      @has_matches = !@matches.empty?
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

  def available_items_show
    if current_user
      @swipe = Swipe.new
      available_items = Item.available(current_user)
      if !available_items.empty?
        @item = available_items.shuffle.sample
      else
        flash[:notice] = "You're out of swipes for the day. Check back tomorrow!"
      end
    else
      redirect_to login_path
    end
  end

  def edit
    @item = Item.find_by(id: params[:id])
    if !@item
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

  def update
    @item = Item.find_by(id: params[:id])
    if @item.update_attributes(item_params)
      flash[:notice] = "Item updated"
      redirect_to @item
    else
      flash[:alert] = "Did not update"
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :avatar)
  end
end
