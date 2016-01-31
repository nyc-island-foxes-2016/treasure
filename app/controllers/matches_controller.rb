class MatchesController < ApplicationController

  def show
    @match = Match.includes(:messages).find(params[:id])
    @my_item = current_user.items.first
    @other_item = @match.other(@my_item)
    @message = Message.new
  end
end
