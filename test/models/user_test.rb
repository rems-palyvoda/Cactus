require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "FirstName", last_name: "LastName",
                      email: "test_user@example.com", password: "foobar",
                      password_confirmation: "foobar")
  end

  test "should_be_valid" do
    assert @user.valid?
  end

  test "first_name_should_be_present" do
    @user.first_name = "   "
    assert_not @user.valid?
  end

  test "last_name_should_be_present" do
    @user.last_name = "   "
    assert_not @user.valid?
  end

  test "email_should_be_present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.first_name  = "a" * 54
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.last_name  = "a" * 54
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password shold be present" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum",
                        media: "https://www.youtube.com/watch?v=5r6yzFEXajQ")
    assert_difference "Post.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    user_one = users(:one)
    user_two = users(:two)
    assert_not user_one.following?(user_two)
    user_one.follow(user_two)
    assert user_one.following?(user_two)
    assert user_two.followers.include?(user_one)
    user_one.unfollow(user_two)
    assert_not user_one.following?(user_two)
  end

  test "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    lana.posts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    michael.posts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    archer.posts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
end
