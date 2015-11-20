require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Johnny Guitar", email: "jjguitar@example.com", password: "tester", password_confirmation: "tester", max_motivation:100, upgrade_points:0)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 26
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "should reset motivation" do
  	@user.update_attribute(:cur_motivation, 1)
    assert_equal 1, @user.cur_motivation
    @user.reset_motivation
		assert_equal 100, @user.cur_motivation
  end
  
  test "exp_to_reach_level should properly calculate the experience-level curve" do
  	assert_equal 0, User.exp_to_reach_level(1)
  	assert_equal 100, User.exp_to_reach_level(2)
  	assert_equal 39810, User.exp_to_reach_level(15)
  end
  
  test "leveling up should increase level and carry over extra buzz" do
  	@user.buzz = 1
  	assert_equal 1, @user.level
  	assert_not @user.level_up?
  	@user.buzz = 105
  	assert @user.level_up?
  	assert_equal 2, @user.level
  	assert_equal 5, @user.buzz
  	assert_equal 2, @user.upgrade_points
  end
  
  test "reviving should restore half of dignity and zero buzz" do
  	@user.cur_dignity = 0
  	@user.buzz = 66
  	@user.revive
  	assert_equal @user.max_dignity / 2, @user.cur_dignity
  	assert_equal 0, @user.buzz
  	
  end
  
end
