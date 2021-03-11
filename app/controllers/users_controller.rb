class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  def info
    if @current_user
      render json: @current_user
    else
      render json: "Not identified"
    end
  end
  def edit
    if decoded_token
      user = @current_user
      user.update(user_params)
    else
      render json: "Cannot Identify"
    end
  end
  def create
    @user = User.new(user_params)
      if @user.save
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}
      else
          render json: {error: "Enter Proper data"}
      end
  end
  def authenticate
      @user = User.find_by(email: params[:email])
      if @user.password.eql?(params[:password])
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid"}
      end
  end
  def auto_login
    render json: @user
  end
  private
  def user_params
    params.permit(:name, :email, :password, :contact, :status)
  end
end