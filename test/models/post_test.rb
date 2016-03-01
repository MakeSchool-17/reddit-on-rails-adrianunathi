require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @subboard = subboards(:michaels_board)
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
    @contentpost.save

    assert @user.posts.first, @subboard.posts.first
  end

  test "link should be valid" do
    @urlpost.link = "http//google.com"
    assert_not @urlpost.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

end
