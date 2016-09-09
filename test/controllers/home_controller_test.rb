require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should get index with user's contacts" do
    current_user = create(:user)
    @controller.stubs(:current_user).returns(current_user)
    other_user = create(:user)
    conversation = create(:conversation, user_one_id: current_user.id, user_other_id: other_user.id)
    contact = create(:contact, user: current_user, target_email: other_user.email, conversation: conversation)
    assert_equal 1, current_user.contacts.count
    get :index
    assert_response :success
  end

end
