require 'test_helper'

class UserLinksControllerTest < ActionController::TestCase
  setup do
    @user_link = user_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_link" do
    assert_difference('UserLink.count') do
      post :create, user_link: { email: @user_link.email, encrypted_password: @user_link.encrypted_password, publicvisible: @user_link.publicvisible, realname: @user_link.realname, salt: @user_link.salt, username: @user_link.username }
    end

    assert_redirected_to user_link_path(assigns(:user_link))
  end

  test "should show user_link" do
    get :show, id: @user_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_link
    assert_response :success
  end

  test "should update user_link" do
    patch :update, id: @user_link, user_link: { email: @user_link.email, encrypted_password: @user_link.encrypted_password, publicvisible: @user_link.publicvisible, realname: @user_link.realname, salt: @user_link.salt, username: @user_link.username }
    assert_redirected_to user_link_path(assigns(:user_link))
  end

  test "should destroy user_link" do
    assert_difference('UserLink.count', -1) do
      delete :destroy, id: @user_link
    end

    assert_redirected_to user_links_path
  end
end
