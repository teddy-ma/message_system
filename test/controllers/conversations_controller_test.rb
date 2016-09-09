require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase

  test "should clear unread count when receiver look into" do
    current_user = create(:user)
    @controller.stubs(:current_user).returns(current_user)
    other_user = create(:user)
    conversation = create(:conversation, user_one_id: current_user.id,
      user_other_id: other_user.id, unread_count: 3, last_reply_user_id: other_user.id)

    get :show, id: conversation.id

    assert_equal 0, conversation.reload.unread_count
  end

  test "should not clear unread count when sender look into" do
    current_user = create(:user)
    @controller.stubs(:current_user).returns(current_user)
    other_user = create(:user)
    conversation = create(:conversation, user_one_id: current_user.id,
      user_other_id: other_user.id, unread_count: 3, last_reply_user_id: current_user.id)

    get :show, id: conversation.id

    assert_equal 3, conversation.reload.unread_count
  end


end
