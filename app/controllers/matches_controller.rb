class MatchesController < ApplicationController

  def show
  	@match = Match.find_by(id: params[:id])
    # binding.pry
  end
end
