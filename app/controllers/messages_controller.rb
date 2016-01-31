class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      redirect_to item_path(@message)
    else
      flash[:notice] = "We could not send your Message"
      redirect_to new_message_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:match_id, :user_id, :content)
  end
end
