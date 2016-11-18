require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should get new" do
    get "/users/new"
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as other user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when looged in as other user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name: @user.last_name,
                                              email: @user.email } } 
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
