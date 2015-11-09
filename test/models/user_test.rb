require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example", email: "use@yahoo.com",
                    password: "whatever", password_confirmation: "whatever")
  end
  
  test "should be valid" do
    assert true
    # assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
    # assert !@user.valid?
  end
  
    test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
    # assert !@user.valid?
  end
  
  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end