class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :place_id, :latitude, :longitude, :user_id, :address, :reviews, :image_url, :image_public_id
  has_many :reviews
  
end
