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
  def json_format(object, token = nil)
    response = Hash.new
    type = object.class.to_s
    if type.to_s.include?("::")
      type = type.split('::')
      type = type[0]
    end
    serializer = (type + "Serializer").constantize
    ser = ActiveModelSerializers::SerializableResource.new(object, each_serializer: serializer)
    response["data"] = {type => ser}
    unless token.nil?
      response["token"] = token
    end
    return response
  end
  
  def is_friend?(user_id)
    a = "Accepted"
    @friend = Friend.where("user_id = ? AND friend_id = ? AND request = ?", @current_user.id, user_id, a)
    if @friend.empty?
      return false
    else
      return true
    end
  end
end
