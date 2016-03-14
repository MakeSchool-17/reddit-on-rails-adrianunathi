class Api::V1::SubscriptionsController < ApplicationController

  def index
    # debugger
    @subscriptions = Subscription.all.map { |subscription| subscription.to_json }
    render json: { subscriptions: @subscriptions }, status: 200
  end

  def create
    @user = User.find_by_username(subscriptions_params[:username])
    @subboard = Subboard.find_by_name(subscriptions_params[:name])
    if @user.nil?
      render json: { error: "User does not exist"}, status: 503
      return
    elsif  @subboard.nil?
      render json: { error: "Subboard does not exist"}, status: 503
      return
    end
    @subscription = @user.subscriptions.build({ subboard: @subboard })
    if @subscription.save
      render json: {}, status: 201
    else
      render json: { error: @subscription.errors.full_messages }, status: 500
    end
  end

  def destroy
    @user = User.find_by_username(params[:username])
    if @user.nil?
      render json: { error: "User does not exist" }, status: 503
      return
    end
    if Subscription.find_by({ user_id: @user.id })
      if Subscription.find_by({ user_id: @user.id }).destroy
        render json: {}, status: 204
      end
    else
      render json: { error: "No subscription found with user" }, status: 503
    end
  end

  private

    def subscriptions_params
      params.require(:subscription).permit(:username, :name)
    end

end
