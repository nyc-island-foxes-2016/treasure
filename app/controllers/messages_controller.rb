class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @match = Match.find_by(id: params[:match_id])
    @message.user = current_user
    @message.match = @match
    @my_item = @match.my_item
    if @message.save
      @match.touch 
      redirect_to item_match_path(@my_item, @match)
    else
      flash[:notice] = "Sorry! We couldn't send you message, phone companies suck"
      redirect_to item_match_path(@my_item, @match)
    end
  end

  private 

  def message_params
    params.require(:message).permit(:content)
  end
end
