require 'test_helper'

class SportLinksControllerTest < ActionController::TestCase
  setup do
    @sport_link = sport_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_link" do
    assert_difference('SportLink.count') do
      post :create, sport_link: { name: @sport_link.name }
    end

    assert_redirected_to sport_link_path(assigns(:sport_link))
  end

  test "should show sport_link" do
    get :show, id: @sport_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sport_link
    assert_response :success
  end

  test "should update sport_link" do
    patch :update, id: @sport_link, sport_link: { name: @sport_link.name }
    assert_redirected_to sport_link_path(assigns(:sport_link))
  end

  test "should destroy sport_link" do
    assert_difference('SportLink.count', -1) do
      delete :destroy, id: @sport_link
    end

    assert_redirected_to sport_links_path
  end
end
