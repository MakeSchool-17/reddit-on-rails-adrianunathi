require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @subboard = subboards(:myboard)
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

  # test "link should be sanitized/valid url" do
  #   invalid_urls = ["http://", "http://www.", "www.", "http://www.wvtesting","http://www.com","http://www. .com","wvtesting.com","www.wvtesting.com","http:/www.wvtesting.com","http//www.wvtesting.com","http:www.wvtesting.com","htp://wvtesting.com/"]
  #
  #   invalid_urls.each do |x|
  #     @urlpost.link = x
  #     assert_not @urlpost.valid?
  #   end
  #
  # end

  # test "order should be most recent first" do
  #
  # end

  test "subboard has post from user" do
    @user.save
    @subboard.save
    @contentpost.save

    assert @user.posts.first, @subboard.posts.first
  end

end
