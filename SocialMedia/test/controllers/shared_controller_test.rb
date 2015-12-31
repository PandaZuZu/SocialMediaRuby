require 'test_helper'

class SharedControllerTest < ActionController::TestCase
  test "should get navigationbar" do
    get :navigationbar
    assert_response :success
  end

end
