module Api
  module V1

    class SubboardsController < ApplicationController

      def create
        # Should create from user
        @subboard = Subboard.new(subboard_params)
        if @subboard.save
          render json: {}, status: 201
        else
          render json: { error: @subboard.errors.full_messages }, status: 500
        end
      end

      def show
        @subboard = Subboard.find_by_name(params[:name])
        if !@subboard.nil?
          render json: @subboard.to_json, status: 200
        else
          render json: { error: "No subboard found with name" }, status: 503
        end
      end

      def destroy
        if Subboard.find_by_name(params[:name])
          if Subboard.find_by_name(params[:name]).destroy
            render json: {}, status: 200
          # else
          #   render json: { error: "Failed deleting subboard" }, status: 503
          end
        else
          render json: { error: "No subboard found with name" }, status: 503
        end
      end

      def update
        @subboard = Subboard.find_by_name(params[:name])
        if @subboard.nil?
          render json: { error: "No subboard found with name" }, status: 503
        else
          if @subboard.update_attributes(subboard_params_update) and not subboard_params_update.empty?
            render json: {}, status: 200
          else
            render json: { error: "Failed updating attributes" }, status: 503
          end
        end
      end

      def index
        @subboards = Array.new
        Subboard.all.each do |board|
          @subboards.append board.to_json
        end
        render json: { subboards: @subboards }, status: 200
      end

      private

        def subboard_params
          params.require(:subboard).permit(:name, :private, :user_id)
        end

        def subboard_params_update
          params.require(:subboard).permit(:private)
        end

    end

  end
end
