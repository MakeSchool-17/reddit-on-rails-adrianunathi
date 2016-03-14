module Api
  module V1

    class PostsController < ApplicationController

      def create
        @user = User.find_by_username(post_params[:author_username])
        @subboard = Subboard.find_by_name(post_params[:name])
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
        @board = Subboard.find_by_name(post_params[:name])
        @posts = @board.posts.map {|post| post.to_json}
        render json: { posts: @posts }, status: 200
      end

      def destroy
        @post = Post.find_by_id(params[:id])
        if not @post.nil?
          if @post.update_attributes({ active: false })
            render json: { post: @post.reload }, status: 200
          end
        else
          render json: { error: "No post found with id" }, status: 503
        end
      end

      private

        def post_params
          params.permit(:title, :content, :link, :author_username, :name)
        end

    end

  end
end
