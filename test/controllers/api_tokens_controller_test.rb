require 'test_helper'

class ApiTokensControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

end
