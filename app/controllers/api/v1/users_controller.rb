module Api
  module V1

    class UsersController < ApplicationController
    end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: {}, status: 201
        else
          render json: { error: @user.errors.full_messages }, status: 500
        end
      end

      def show
        @user = User.find_by_id(params[:id])
        if !@user.nil?
          render json: @user, status: 200
        else
          render json: { error: "No users found with id" }, status: 503
        end

      end

      def destroy
        if User.find_by_id(params[:id])
          if User.find(params[:id]).destroy
            render json: {}, status: 200
          end
        else
          render json: { error: "No users found with id" }, status: 503
        end
      end

      def update
        @user = User.find_by_id(params[:id])
        if @user.nil?
          render json: { error: "No users found with id" }, status: 503
        else
          if @user.update_attributes(user_params)
            render json: {}, status: 200
          else
            render json: { error: "Failed updating attributes" }, status: 503
          end
        end
      end

      def index
        @user = User.all
        render json: { status: 200, users: @user }
      end

      private

        def user_params
          params.require(:user).permit(:username, :email)
        end

  end
end

