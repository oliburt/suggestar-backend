class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :place_id, :latitude, :longitude, :user_id, :address, :reviews
  has_many :reviews
  
end
