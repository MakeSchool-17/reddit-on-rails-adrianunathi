module Api
  module V1

    class CommentsController < ApplicationController

      def create
        @user = User.find_by_username(comment_params[:author_username])

        if comment_params[:parent_type] == 'Post'
          @parent = Post.find_by_id(comment_params[:parent_id])
        elsif comment_params[:parent_type] == 'Comment'
          @parent = Comment.find_by_id(comment_params[:parent_id])
        end

        if @parent.nil?
          render json: { error: "No parent of type #{comment_params[:parent_type]} with id" }, status: 500
          return
        end

        @comment = @user.comments.build({content: comment_params[:content], parent: @parent })

        if @comment.save
          render json: {}, status: 201
        else
          render json: { error: @comment.errors.full_messages }, status: 500
        end
      end

      def show
        @comment = Comment.find_by_id(params[:id])
        if not @comment.nil?
          render json: @comment.to_json, status: 200
        else
          render json: { error: "No comment found with id" }, status: 503
        end
      end

      def index
        @comments = Array.new
        Comment.all.each do |comment|
          @comments.append comment.to_json
        end
        render json: { status: 200, comments: @comments }
      end

      def destroy
        if Comment.find_by_id(params[:id])
          if Comment.find_by_id(params[:id]).destroy
            render json: {}, status: 200
          else
            render json: { error: "Failed deleting Comment" }, status: 503
          end
        else
          render json: { error: "No Comment found with id" }, status: 503
        end
      end

      private

        def comment_params
          params.require(:comment).permit(:content, :post_id, :parent_id, :parent_type, :author_username)
        end

    end

  end
end

