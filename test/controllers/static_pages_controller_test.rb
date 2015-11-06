require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  # test "should get home" do
  #   get :root
  #   assert_response :success
  # end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get admin" do
    get :admin
    assert_response :success
  end

end
