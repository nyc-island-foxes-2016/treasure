class ItemsController < ApplicationController

  #before_action for ownership

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      flash[:notice] = "We could not save your treasure. Please try again."
      redirect_to new_item_path
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
    if @item && @item.user == current_user
      @matches = @item.all_matches
      @has_matches = @matches.any?
      @swapped_match = @item.swapped_matches
      @other_swapped_item = @swapped_match.other(@item).name
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

  def available_items_show
    @swipe = Swipe.new
    available_items = Item.available(current_user)
    @item = available_items.shuffle.sample
    if request.xhr?
      if available_items.any?
        render json: @item
      else
        render json:{message: "No More Items"}
      end
    else
      if available_items.any?
        @item
      else
        render "items/_out_of_swipes"
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
    if @item.user != current_user
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

  def update
    @item = Item.find_by(id: params[:id])

    if params[:item][:swapped]
      if @item.swapped == false
        @match = Match.find(params[:match])
        @item.update_attributes(swapped: true)
        @match.make_swap_if_mutual_swap(@item)
        if @match.swapped_at != nil
          flash[:notice] = "Both treasures have confirmed your swap!"
        else
          flash[:notice] = 'When <%= @match.other_item.name %> confirms, your items will be unlisted.'
        end
      end
      redirect_to item_match_path(@item, @match)

    else
      if @item.update_attributes(item_params)
        flash[:notice] = "Item updated"
        redirect_to @item
      else
        flash[:alert] = "Did not update"
        render :edit
      end
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :avatar).merge(user: current_user)
  end
end
