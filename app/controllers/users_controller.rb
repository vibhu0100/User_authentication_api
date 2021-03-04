class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
    
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
        params.permit(:name,:email,:password)
    end
end
