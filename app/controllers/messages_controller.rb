class MessagesController < ApplicationController

  def for_match
    @match = Match.find_by(id: params[:match_id])
    @all_messages = @match.messages
    render :create, layout: false
  end

  def create
    @match = Match.find_by(id: params[:match_id])
    @message = @match.message.new(message_params)
    @my_item = current_user.items.first
    if @message.save
      @match.touch
      if request.xhr?
        @all_messages = @match.messages
          puts @match.messages.to_json
          render :create, layout: false
        else
          redirect_to item_match_path(@my_item, @match)
      end
    else
      if request.xhr?
      flash[:notice] = "Sorry! We couldn't send your message."
        render :create, layout: false
      end
      flash[:notice] = "Sorry! We couldn't send your message."
      redirect_to item_match_path(@my_item, @match)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user: current_user)
  end
end
