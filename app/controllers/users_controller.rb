class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { status: 201 }
    else
      render json: { error: @user.errors }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #Show flash that it succeeded or something
    else
      # Show edit page ?
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
