class MatchesController < ApplicationController

  def show
    @match = Match.includes(:messages).find(params[:id])
    @my_item =@match.my_item
    @message = Message.new
    binding.pry
  end
end
