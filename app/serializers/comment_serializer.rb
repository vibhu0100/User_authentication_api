class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :desc, :commented_by, :created

  def commented_by
    User.find(object.comment_user_id).name
  end

  def created
    distance_of_time_in_words(object.created_at, Time.now) + " ago"
  end
end
