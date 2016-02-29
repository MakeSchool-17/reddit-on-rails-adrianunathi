require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = Comment.new(content: "Some content")
  end

  test "should be valid" do
    assert @comment.valid?
  end

end
