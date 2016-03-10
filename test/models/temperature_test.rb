require 'test_helper'

class TemperatureTest < ActiveSupport::TestCase

  def setup
    @otheruser = users(:leila)
    @post = posts(:bobs_post)
    @temperature = @post.tempsetters.build(user: @otheruser, temptype: 'hot')
  end

  test "should be valid" do
    assert @temperature.valid?
  end

  test "should require a post/comment" do
    sample_temp = Temperature.new(post: nil, user: @otheruser)
    assert_not sample_temp.valid?
  end

  test "should require a user" do
    sample_temp = Temperature.new(post: @subboard, user: nil)
    assert_not sample_temp.valid?
  end

  test "should require a temptype" do
    sample_temp = Temperature.new(post: @subboard, user: @otheruser, temptype: nil)
    assert_not sample_temp.valid?
  end

  test "should be a valid user" do
    invalid_user = User.new
    temperature = @post.tempsetters.build(user: invalid_user, temptype: nil)

    assert_not temperature.valid?
  end

  test "user has thermostats of votes" do
    @otheruser.save
    @post.save
    @temperature.save
    assert_equal @post.tempsetters.first.id, @otheruser.thermostats.first.id
  end

end
