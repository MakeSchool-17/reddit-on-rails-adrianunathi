require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  def setup
    @otheruser = users(:leila)
    @subboard = subboards(:bobs_board)
    @subscription = @subboard.subscribers.build(user: @otheruser)
  end

  test "should be valid" do
    assert @subscription.valid?
  end

  test "should require a subboard" do
    sample_sub = Subscription.new(subboard: nil, user: @otheruser)
    assert_not sample_sub.valid?
  end

  test "should require a user" do
    sample_sub = Subscription.new(subboard: @subboard, user: nil)
    assert_not sample_sub.valid?
  end

  test "should be a valid user" do
    invalid_user = User.new
    subscription = @subboard.subscribers.build(user: invalid_user)

    assert_not subscription.valid?
  end

  test "user has subscriptions to subboards" do
    @otheruser.save
    @subboard.save
    assert_equal @subboard.subscribers.first.id, @otheruser.subscriptions.first.id
  end

end
