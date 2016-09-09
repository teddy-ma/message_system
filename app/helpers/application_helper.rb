module ApplicationHelper
  def show_unread_count(conversation)
    return "" if conversation.unread_count == 0
    if conversation.last_reply_user_id != current_user.id
      content_tag(:span, conversation.unread_count, style: "color: red")
    end
  end
end
