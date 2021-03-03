class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  def index
    @users = User.all
    paginate @users, per_page: 2
  end
  def info
    $check = true 
    if decoded_token
      render json: @current_user
    else
      render json: 'Not identified'
    end
  end

  def edit
    if decoded_token
      user = @current_user
      user.update(user_params)
    else
      render json: 'Cannot Identify'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Enter Proper data' }
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
    if @user.otp_secret.eql?(params[:otp])
      token = encode_token({ user_id: @user.id })
      render json: user_token_hash(token)
    else
      render json: 'Invalid OTP'
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user.password.eql?(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: user_token_hash(token)
    else
      render json: { error: 'Invalid' }
    end
  end

  def logout
    @current_user.update(otp_secret: nil)
  end

  def auto_login
    render json: @user
  end

  def verify_for_password
    @user = User.find_by(contact: params[:contact])
    if @user.otp_secret.eql?(params[:otp])
      render json: reset_password_url
    else
      render json: 'Invalid'
    end
  end

  def reset_password
    @user = User.find_by(contact: params[:contact])
    if @user.update(password: params[:password])
      puts @user.password
      render json: 'Password reset'
    else
      render json: 'Something went'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :contact, :status, :otp)
  end
  def user_token_hash(token)
    hash = Hash.new
    hash[:user] = @current_user
    hash[:token] = token
    return hash
  end
end
