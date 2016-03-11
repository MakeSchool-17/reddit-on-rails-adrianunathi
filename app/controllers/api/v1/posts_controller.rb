module Api
  module V1

    class PostsController < ApplicationController

      def create
        @user = User.find_by_username(post_params[:author_username])
        @subboard = Subboard.find_by_name(post_params[:subboard_name])
        @post = @user.posts.build({ title: post_params[:title],
                                    link: post_params[:link],
                                    content: post_params[:content],
                                    subboard: @subboard })
        if @post.save
          render json: {}, status: 201
        else
          render json: { error: @post.errors.full_messages }, status: 500
        end
      end

      def show
        @post = Post.find_by_id(params[:id])
        if not @post.nil?
          render json: @post.to_json, status: 200
        else
          render json: { error: "No post found with id" }, status: 503
        end
      end

      def index
        @posts = Array.new
        Post.all.each do |post|
          @posts.append post.to_json
        end
        render json: { posts: @posts }, status: 200
      end

      def destroy
        @post = Post.find_by_id(params[:id])
        if not @post.nil?
          if @post.update_attributes({ active: false })
            render json: { post: @post.reload }, status: 200
          else
            render json: { error: "Failed deactivating post" }, status: 503
          end
        else
          render json: { error: "No post found with id" }, status: 503
        end
      end

      private

        def post_params
          params.require(:post).permit(:title, :content, :link, :author_username, :subboard_name)
        end

    end

  end
end
