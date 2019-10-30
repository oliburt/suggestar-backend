class Venue < ApplicationRecord
  belongs_to :user
  has_many :listings
  has_one :address
end
