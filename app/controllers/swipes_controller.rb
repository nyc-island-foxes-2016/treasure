class SwipesController < ApplicationController

  def create
    @swipe = Swipe.new(swipe_params)
    @swipe.my_item = current_user.items.first
    if @swipe.save
      @match = @swipe.make_match
      if request.xhr?
          respond_to do |format|
            format.json { render json: {match: @match} }
            format.html { redirect_to available_items_path }
          end
      else
        redirect_to available_items_path
      end
    else
      flash[:notice] = "Something went wrong. Sorry!"
      redirect_to available_items_path
    end
  end

  private

  def swipe_params
    params.require(:swipe).permit(:other_item_id, :direction)
  end
end
