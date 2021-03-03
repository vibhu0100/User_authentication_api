class ApplicationController < ActionController::API
  before_action :authorized
  before_action :get_current_user
  def authorized
    render json: {message: "Please log in"}, status: :unauthorized unless logged_in?
  end
  def logged_in?
    !!logged_in_user
  end
  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end
  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        t = JWT.decode(token, 'secret', true, algorith: 'HS256')
      rescue JWT::DecodeError
        nil
      end
      return t
    end
  end
  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end
  def auth_header
    request.headers['Authorization']
  end
  private
  def get_current_user
    @current_user = logged_in_user
  end
end
