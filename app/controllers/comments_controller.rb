class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      # What to dhow when comment made
    else
      # Save failed
    end
  end

  def destroy
    @comment.destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id, :parent)
    end

end
