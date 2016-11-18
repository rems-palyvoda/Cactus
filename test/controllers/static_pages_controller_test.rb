require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
  end

  test "should get index" do
    get root_path
    assert_response :success
  end

  test "root_path is static page index" do
    get root_path
    assert_template "index"
  end

  test "logged user see feed" do
    log_in_as(@user)
    get root_path
    assert_select "body div#feed"
  end

  test "unlogged user see login form" do
    get root_path
    assert_select "form"
  end
end
