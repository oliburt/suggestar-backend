class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_one :address
  belongs_to :user
  has_many :listings
  
end
