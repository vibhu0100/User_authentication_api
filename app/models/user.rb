class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  def post_list
    Post.where("user_id = :user_id", user_id: id)
  end
end
