module Api
  module V1

    class ModeratorsController < ApplicationController

      def index
        @board = Subboard.find_by_name(params[:name])
        @moderators = @board.moderators.map { |moderator| moderator.to_json }
        render json: { moderators: @moderators }, status: 200
      end

      def create
        @user = User.find_by_username(moderator_params[:username])
        @subboard = Subboard.find_by_name(moderator_params[:name])
        if @user.nil?
          render json: { error: "User does not exist"}, status: 503
          return
        elsif  @subboard.nil?
          render json: { error: "Subboard does not exist"}, status: 503
          return
        end
        @moderator = @user.moderating.build({ subboard: @subboard })
        if @moderator.save
          render json: {}, status: 201
        else
          render json: { error: @moderator.errors.full_messages }, status: 500
        end
      end

      def destroy
        @user = User.find_by_username(params[:username])
        if @user.nil?
          render json: { error: "User does not exist" }, status: 503
          return
        end
        if Moderator.find_by({ user_id: @user.id })
          if Moderator.find_by({ user_id: @user.id }).destroy
            render json: {}, status: 204
          end
        else
          render json: { error: "No moderator found with user" }, status: 503
        end
      end

      private

      def moderator_params
        params.permit(:username, :name)
      end


    end

  end
end

