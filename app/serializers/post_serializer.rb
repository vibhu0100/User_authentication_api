class PostSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  include ActiveStorage::Blobs
  Rails.application.routes.url_helpers
  has_many :comments
  attributes :id, :owner, :caption, :images, :created, :image
  def owner
    User.find(object.user_id).name
  end
  def image
    object.images.size()
  end
  
  def created
    distance_of_time_in_words(object.created_at, Time.now) + " ago"
  end
end
