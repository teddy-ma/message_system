require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  test "should create message and increase unread count when last reply user is self" do
    current_user = create(:user)
    @controller.stubs(:current_user).returns(current_user)
    other_user = create(:user)
    conversation = create(:conversation, user_one_id: current_user.id,
      user_other_id: other_user.id, unread_count: 3, last_reply_user_id: current_user.id)

    assert_difference('conversation.messages.count') do
      post :create, conversation_id: conversation.id, message: {body: "hello"}, format: :js
    end
    conversation.reload

    assert_equal 1, conversation.messages.count
    assert_equal 4, conversation.unread_count
  end

  test "should create message and increase unread count when last reply user is not self" do
    current_user = create(:user)
    @controller.stubs(:current_user).returns(current_user)
    other_user = create(:user)
    conversation = create(:conversation, user_one_id: current_user.id,
      user_other_id: other_user.id, unread_count: 5, last_reply_user_id: other_user.id)

    assert_difference('conversation.messages.count') do
      post :create, conversation_id: conversation.id, message: {body: "hello"}, format: :js
    end
    conversation.reload

    assert_equal 1, conversation.unread_count
  end

end
