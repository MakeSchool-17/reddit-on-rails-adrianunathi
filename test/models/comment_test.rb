require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:bob)
    @subboard = subboards(:bobs_board)
    @post = posts(:bobs_post)
    @comment = @user.comments.build(content: "Life is great.", post: @post)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "subcomment should be valid" do
    @comment.save!
    new_comment = @user.comments.build(content: "Life is even greater.", post: @post, parent: @comment)
    assert new_comment.valid?
  end

  test "comment content should not be empty" do
    empty_comment = @user.comments.build(content: "  ", post: @post)
    assert_not empty_comment.valid?
  end

  test "comment should have post id" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end

  test "user has comments" do
    @comment.save!
    assert_equal @user.comments.first, @comment
  end

  test "post has comments" do
    @comment.save!
    assert_equal @post.comments.first, @comment
  end

  test "comment has comments" do
    @comment.save!
    new_comment = @user.comments.build(content: "Life is even greater.", post: @post, parent: @comment)
    new_comment.save!
    assert_equal @comment.subcomments.first, new_comment
  end

  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end

end
