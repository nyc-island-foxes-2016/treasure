class SwipesController < ApplicationController
      respond_to do |format|
        format.json {render json: @swipe}
        format.html {}
      end

  def create
    binding.pry
    @swipe = Swipe.new(swipe_params)
    @swipe.my_item = current_user.items.first
    if @swipe.save
      if @swipe.make_match
        flash[:notice] = "You matched with #{@swipe.other_item.name}. Go to My Item to start a message with them."
        redirect_to available_items_path
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
