module Api
  module V1

    class UsersController < ApplicationController

      def create
        @user = User.new(user_params)
        if @user.save
          render json: {}, status: 201
        else
          render json: { error: @user.errors.full_messages }, status: 500
        end
      end

      def show
        @user = User.find_by_username(params[:username])
        if !@user.nil?
          render json: @user.to_json, status: 200
        else
          render json: { error: "No users found with username" }, status: 503
        end

      end

      def destroy
        if User.find_by_username(params[:username])
          if User.find_by_username(params[:username]).destroy
            render json: {}, status: 200
          end
        else
          render json: { error: "No users found with username" }, status: 503
        end
      end

      def update
        @user = User.find_by_username(params[:username])
        if @user.nil?
          render json: { error: "No users found with username" }, status: 503
        else
          if @user.update_attributes(user_params)
            render json: {}, status: 200
          else
            render json: { error: "Failed updating attributes" }, status: 503
          end
        end
      end

      def index
        @users = User.all.map {|user| user.to_json}
        render json: { users: @users }, status: 200
      end

      private

        def user_params
          params.require(:user).permit(:username, :email)
        end

    end

  end
end
