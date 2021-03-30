class Post < ApplicationRecord
  has_many_attached :images
  has_many :likes
end
