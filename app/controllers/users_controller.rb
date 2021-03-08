class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  def info
    if decoded_token
      user_id = decoded_token[0]['user_id']
      user = User.find(user_id)
      render json: user
    else
      render json: "Not identified"
    end
  end
  def edit
    if decoded_token
      user_id = decoded_token[0]['user_id']
      user = User.find(user_id)
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
  def send_otp
    user = User.find_by(contact: params[:contact])
    if user
      otp = rand(4000..9000)
      if user.update(otp_secret: otp)
        puts otp
        render json: 'OTP sent'
      else
        render json: "Couldn't send OTP"
      end
    else
      render json: 'Your contact is not registered'
    end
  end
  def verify
    @user = User.find_by(contact: params[:contact])
    puts params[:otp].class
    puts @user.otp_secret.class
    if @user.otp_secret.eql?(params[:otp])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: 'Invalid OTP'
    end
  end
  def login
    @user = User.find_by(email: params[:email])
    if @user.password.eql?(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid' }
    end
  end
  def logout
    logged_in_user.update(otp_secret: nil)
  end
  def auto_login
    render json: @user
  end
  private
  def user_params
    params.permit(:name, :email, :password, :contact, :status, :otp)
  end
  def user_profile
    user = logged_in_user
    { 'name' => user.name, 'email' => user.email, 'contact' => user.contact, 'status' => user.status,
      'password' => user.password }
  end
end