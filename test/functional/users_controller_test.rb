require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get random_login" do
    get :random_login
    assert_response :success
  end

end
