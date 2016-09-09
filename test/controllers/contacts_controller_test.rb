require 'test_helper'

class ContactsControllerTest < ActionController::TestCase

  test "should create new contact when everything is new" do
    current_user = create(:user)
    @controller.stubs(:current_user).returns(current_user)
    other_user = create(:user)

    post :create, email: other_user.email
    assert_response 302

    assert_equal 1, Contact.count
    assert_equal 1, Conversation.count
  end

  test "should create new contact when destroyed before" do
    current_user = create(:user)
    @controller.stubs(:current_user).returns(current_user)
    other_user = create(:user)
    conversation = create(:conversation, user_one_id: current_user.id, user_other_id: other_user.id)

    post :create, email: other_user.email
    assert_response 302

    assert_equal 1, Contact.count
    assert_equal 1, Conversation.count
  end

end
