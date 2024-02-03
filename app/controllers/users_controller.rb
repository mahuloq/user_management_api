class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { message: "User deleted successfully" }
    else
      render json: { error: "Unable to delete user" }, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end

    def user_params
      params.require(:user).permit(:full_name, :email, :age)
    end
end
