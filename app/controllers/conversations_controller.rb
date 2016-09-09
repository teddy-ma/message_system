class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find(params[:id])
    if @conversation.both_user_ids.include?(current_user.id)
      @conversation.clear_unread_count(current_user.id)
      @message = Message.new
    else
      raise ActiveRecord::RecordNotFound
    end
  end

end
