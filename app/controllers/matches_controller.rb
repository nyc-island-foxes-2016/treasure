class MatchesController < ApplicationController

  def show
  	@match = Match.find_by(id: params[:id])
    @messages = @match.messages
    # binding.pry
  end
end
