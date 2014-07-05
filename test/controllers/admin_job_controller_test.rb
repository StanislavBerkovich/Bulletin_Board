require 'test_helper'

class AdminJobControllerTest < ActionController::TestCase
  test "should get nonpublished" do
    get :nonpublished
    assert_response :success
  end

end
