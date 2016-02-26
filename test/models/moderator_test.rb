require 'test_helper'

class ModeratorTest < ActiveSupport::TestCase

  def setup
    @otheruser = users(:two)
    @subboard = subboards(:myboard)
    @moderator = @subboard.moderators.build(user: @otheruser)
  end

  test "should be valid" do
    assert @moderator.valid?
  end

  test "should require a subboard" do
    sample_mod = Moderator.new(subboard: nil, user: @otheruser)
    assert_not sample_mod.valid?
  end

  test "should require a user" do
    sample_mod = Moderator.new(subboard: @subboard, user: nil)
    assert_not sample_mod.valid?
  end

  test "should be a valid user" do
    invalid_user = User.new
    moderator = @subboard.moderators.build(user: invalid_user)

    assert_not moderator.valid?
  end

end
