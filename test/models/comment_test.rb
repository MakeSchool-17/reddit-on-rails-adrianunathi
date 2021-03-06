require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:bob)
    @subboard = subboards(:bobs_board)
    @post = posts(:bobs_post)
    @comment = @user.comments.build(content: "Life is great.", parent: @post)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "subcomment should be valid" do
    @comment.save!
    new_comment = @user.comments.build(content: "Life is even greater.", parent: @comment)
    assert new_comment.valid?
  end

  test "comment content should not be empty" do
    empty_comment = @user.comments.build(content: "  ", parent: @post)
    assert_not empty_comment.valid?
  end

  test "comment should have parent id" do
    @comment.parent_id = nil
    assert_not @comment.valid?
  end

  test "comment should have parent type" do
    @comment.parent_type = nil
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
    new_comment = @user.comments.build(content: "Life is even greater.", parent: @comment)
    new_comment.save!
    assert_equal @comment.subcomments.first, new_comment
  end

  # test "temperature should be 0 initially" do
  #   assert_equal 0, @comment.temperature
  # end
  #
  # test "temperature should be valid" do
  #   @comment.temperature = 100
  #   assert @comment.valid?
  # end
  #
  # test "temperature must be an integer" do
  #   @comment.temperature = "bob"
  #   assert_not @comment.valid?
  #   @comment.temperature = 10.124
  #   assert_not @comment.valid?
  # end

  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end

end
