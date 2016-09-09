class MessagesController < ApplicationController

  def create
    conversation = Conversation.find(params[:conversation_id])
    if conversation.both_user_ids.include?(current_user.id)
      @message = conversation.messages.create(body: message_params[:body], sender: current_user)
      conversation.increment_unread_count(current_user.id)

      target_user = conversation.target_user(current_user)
      unless target_user.contacts.where(target_email: current_user.email).exists?
        target_user.contacts.create(conversation: conversation,
          target_email: current_user.email, last_touch_at: DateTime.now)
      end
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def destroy
    conversation = Conversation.find(params[:conversation_id])
    if conversation.both_user_ids.include?(current_user.id)
      @message = conversation.messages.find(params[:id])
      @message.destroy
      conversation.decrement_unread_count(current_user.id, @message)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

end
