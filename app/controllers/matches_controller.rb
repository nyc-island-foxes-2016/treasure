class MatchesController < ApplicationController

  def show
    @match = Match.includes(:messages).find(params[:id])
    @my_item =@match.my_item
    @other_item =@match.other_item
    @message = Message.new
  end
end
