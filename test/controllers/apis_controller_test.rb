require 'test_helper'

class ApisControllerTest < ActionController::TestCase
  test "should get fatsecret" do
    get :fatsecret
    assert_response :success
  end

end
