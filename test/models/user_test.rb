require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "devise works" do
    user = create(:user)
    assert user
  end
end
