class PostSerializer < ActiveModel::Serializer
  attributes :id, :owner, :caption, :images, :created_at, :updated_at, :liked_by
  def owner
    User.find(object.user_id).name
  end
  def liked_by
    users = []
    object.likes.each do |l|
      users.append(User.find(l.user_id).name)
    end
    return users
  end
end
