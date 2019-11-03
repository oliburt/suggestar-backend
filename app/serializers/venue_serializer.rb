class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :place_id, :latitude, :longitude
  belongs_to :user
  has_many :listings
  
end
