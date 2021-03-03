class PostSerializer < ActiveModel::Serializer
  attributes :id, :owner, :caption, :images, :created_at, :updated_at
  def owner
    User.find(object.user_id).name
  end
end
