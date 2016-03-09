module Api
  module V1

    class SubboardsController < ApplicationController

      def create
        @subboard = Subboard.new(subboard_params)
        if @subboard.save
          render json: {}, status: 201
        else
          render json: { error: @subboard.errors.full_messages }, status: 500
        end
      end

      def show
        @subboard = Subboard.find_by_id(params[:id])
        if !@subboard.nil?
          render json: @subboard, status: 200
        else
          render json: { error: "No subboard found with id" }, status: 503
        end

      end

      def destroy
        if Subboard.find_by_id(params[:id])
          if Subboard.find(params[:id]).destroy
            render json: {}, status: 200
          end
        else
          render json: { error: "No subboard found with id" }, status: 503
        end
      end

      def update
        @subboard = Subboard.find_by_id(params[:id])
        if @subboard.nil?
          render json: { error: "No subboard found with id" }, status: 503
        else
          if @subboard.update_attributes(subboard_params_update)
            render json: {}, status: 200
          else
            render json: { error: "Failed updating attributes" }, status: 503
          end
        end
      end

      def index
        @subboard = Subboard.all
        render json: { status: 200, subboards: @subboard }
      end

      private

      def subboard_params
        params.require(:subboard).permit(:name, :private, :user_id)
      end

      def subboard_params_update
        params.require(:subboard).permit(:private)
      end

      # def identifier
      #   params[:id] unless params[:id].nil?
      #   params[:name] unless params[:id].nil?
      # end

    end

  end
end

