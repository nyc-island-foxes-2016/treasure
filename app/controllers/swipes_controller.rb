class SwipesController < ApplicationController

  def create
    @swipe = Swipe.new(swipe_params)
    @swipe.my_item = current_user.items.first
    if @swipe.save
      @swipe.make_match
      @item = Item.available(current_user).shuffle.sample
      respond_to do |format|
        format.json { render json: @item }
        format.html { redirect_to available_items_path }
      end
    else
      flash[:notice] = "Something went wrong. Sorry!"
      redirect_to available_items_path
      #TODO: figure out where to redirect_to or what to render
    end
  end

  private

  def swipe_params
    params.require(:swipe).permit(:other_item_id, :direction)
  end
end
