class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @match = Match.find_by(id: params[:match_id])
    @message.user = current_user
    @message.match = @match
    @my_item = current_user.items.first
    if @message.save
      @match.touch

      if request.xhr?
        @all_messages = @match.messages
        @all_users = @all_messages.map { |message| user= User.find_by(id: message.user_id) }
        @user = @message.user
          puts @match.messages.to_json
          render :create, layout: false
        else
          redirect_to item_match_path(@my_item, @match)
      end
    else
      flash[:notice] = "Sorry! We couldn't send your message, phone companies suck"
      redirect_to item_match_path(@my_item, @match)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
