class ContactsController < ApplicationController

  def create
    target_user = User.where(email: params[:email]).first
    return redirect_to root_url, alert: "用户不存在" unless target_user
    if current_user.contacts.where(target_email: target_user.email).exists?
      return redirect_to root_url, alert: "联系人已经存在"
    end
    unless conversation = Conversation.find_by_user_ids(current_user.id, target_user.id)
      conversation = Conversation.create_by_user_ids(current_user.id, target_user.id)
    end
    current_user.contacts.create!(conversation: conversation,
      target_email: target_user.email, last_touch_at: DateTime.now)

    return redirect_to root_url, alert: "联系人创建成功"
  end

end
