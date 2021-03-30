class FriendSerializer < ActiveModel::Serializer
  attributes :id, :user, :request 
  def user
    if $friend_flag == true
      id = object.friend_id
    elsif $friend_flag == false
      id = object.user_id
    end
    ActiveModelSerializers::SerializableResource.new(User.find(id), each_serializer: UserSerializer)
  end
end
