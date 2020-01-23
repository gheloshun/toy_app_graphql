require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com")
  end

  test "should be valid?" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = ""
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "first name maximum length should be 50" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last name maximum length should be 50" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email maximum length should be 255" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should accept valid format" do
    VALID_EMAIL = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
                    first.last@foo.jp alice+bar@baz.cn]
    VALID_EMAIL.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?
    end
  end

  test "email should reject invalid format" do
    INVALID_EMAIL = %w[user@example,com user_at_foo.org user.name@example.
                      foo@bar_baz.com foo@bar+baz.com]
    INVALID_EMAIL.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end

    test "email should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      assert_not duplicate_user.valid?
    end

end
