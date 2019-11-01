class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :full_name
  has_many :venues
end
