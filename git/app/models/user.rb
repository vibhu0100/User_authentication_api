class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  reg_alpha = /\A[a-zA-Z]+\z/
  validates :name, presence: true, format: {with: reg_alpha}
  reg_email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with:reg_email}
  validates :contact, numericality: { only_integer: true}, length: {is: 10}
  validates :password, length: {minimum: 6}
  validates :status, length: {maximum: 100} 
end
  