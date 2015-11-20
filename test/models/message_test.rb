require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @message = Message.new(subject:"Subj", content: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @message.valid?
  end

  test "user id should be present" do
    @message.user_id = nil
    assert_not @message.valid?
  end
end
