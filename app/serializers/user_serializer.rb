class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :contact, :status
  attributes :id, :name, :email, :contact, :status, :password if $check == true 
end
