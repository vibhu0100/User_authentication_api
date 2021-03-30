class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :friends
  def friend
    status = 'Accepted'
    Friend.where("user_id=? AND request=?",  self.id, status)
  end

  def request
    status = 'Requested'
    Friend.where("friend_id=? AND request=?",  self.id, status)
  end

  def feed
    a = 'Accepted'
    friend_ids = "(SELECT friend_id FROM friends WHERE user_id=#{self.id} AND request='Accepted')"
    Post.where("user_id In #{friend_ids} OR user_id IN (SELECT id FROM users WHERE public_acc=true) OR user_id=?", self.id)
  end
end
