class ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :ticket_url, :age_restriction, :begin_datetime, :end_datetime
  has_many :categories
  belongs_to :venue
end
