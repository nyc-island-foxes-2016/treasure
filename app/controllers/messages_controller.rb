class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @match = Match.find_by(id: params[:match_id])
    @message.user = current_user
    @message.match = @match
    @my_item = @match.my_item
    @match.touch if @message.save

    redirect_to item_match_path(@my_item, @match)
  end
    

  private 

  def message_params
    params.require(:message).permit(:content)
  end
end
