require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "create should require logged_in user" do
    assert_no_difference "Relationships.count" do
      post relationships_path
    end
    assert_redirected_to login_url
  end

  test "destroy shuold require logged-in user" do
    assert_no_difference "Relationships.count" do
      delete relationships_path(relationship(:one))
    end
    assert_redirected_to root_url
  end
end
