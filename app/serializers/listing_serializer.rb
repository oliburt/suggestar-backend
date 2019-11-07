class ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :ticket_url, :age_restriction, :begin_datetime, :end_datetime, :likes, :venue_id, :user_id
  has_many :categories
  # belongs_to :venue

  def user_id
    self.object.venue.user.id
  end

end
