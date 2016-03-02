class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # What to dhow when comment made
    else
      # Save failed
    end
  end

  def destroy
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :link, :subboard_id)
  end

end
