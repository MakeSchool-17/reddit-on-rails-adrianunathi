require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  def setup
    @user = users(:james)
    @subboard = subboards(:cats_board)
    @subscription = @subboard.subscribers.build(user: @user)
  end

  test "should be valid" do
    assert @subscription.valid?
  end

  test "should require a subboard" do
    sample_sub = Subscription.new(subboard: nil, user: @user)
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
    @user.save
    @subboard.save
    assert_equal @subboard.subscribers.first.id, @user.subscriptions.first.id
  end

  test "to_json outputs correctly" do
    json = @subscription.to_json
    expected_json = { username: @subscription.user.username, name: @subscription.subboard.name }
    assert_equal json, expected_json
  end

end
