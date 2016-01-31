class MatchesController < ApplicationController

  def show
    @my_item = Item.find_by(id: params[:item_id])
    if @my_item && @my_item.user == current_user
      @match = Match.includes(:messages).find(params[:id])
      @other_item = @match.other(@my_item)
      @message = Message.new
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end
end
