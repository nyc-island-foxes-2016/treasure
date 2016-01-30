class SwipesController < ApplicationController

  def create
    @swipe = Swipe.new(swipe_params)
    @swipe.my_item = current_user.items.first
    if @swipe.save
      if @swipe.make_match
      end
      redirect_to available_items_path
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
