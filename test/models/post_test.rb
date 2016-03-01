require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:bob)
    @subboard = subboards(:bobs_board)
    @urlpost = @user.posts.build(title: "Sample Post", link: "https://github.com", subboard: @subboard)
    @contentpost = @user.posts.build(title: "Sample Post", content: "This is a bunch of text content", subboard: @subboard)
  end

  test "should be valid" do
    assert @contentpost.valid?
    assert @urlpost.valid?
  end

  test "user id should be present" do
    @contentpost.user_id = nil
    assert_not @contentpost.valid?
  end

  test "subboard id should be present" do
    @contentpost.subboard_id = nil
    assert_not @contentpost.valid?
  end

  test "should not have both link and content" do
    post_with_both = @user.posts.build(title: "Sample Post", link: "https://github.com", content: "Content here", subboard: @subboard)
    assert_not post_with_both.valid?
  end

  test "should have a link or content" do
    post_with_both = @user.posts.build(title: "Sample Post", subboard: @subboard)
    assert_not post_with_both.valid?
  end

  test "subboard has post from user" do
    @contentpost.save!
    assert @user.posts.first, @subboard.posts.first
  end

  test "bad link should be invalid" do
    @urlpost.link = "http//google.com"
    assert_not @urlpost.valid?
  end

  test "temperature should be 0 initially" do
    assert_equal 0, @contentpost.temperature
  end

  test "temperature should be valid" do
    @contentpost.temperature = 100
    assert @contentpost.valid?
  end

  test "temperature must be an integer" do
    @contentpost.temperature = "bob"
    assert_not @contentpost.valid?
    @urlpost.temperature = 10.124
    assert_not @urlpost.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

end
