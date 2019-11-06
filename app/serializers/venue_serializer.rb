class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :place_id, :latitude, :longitude, :current_listings, :user_id, :address, :reviews

  def current_listings
    self.object.listings.filter{ |listing| listing.within_correct_time }
  end
end
