module Api
  module V1

    class ModeratorsController < ApplicationController

      def create
        @subboard = Subboard.find(params[:subboard_id])
        # create moderator with subboard.
      end

      def destroy

      end

    end

  end
end

