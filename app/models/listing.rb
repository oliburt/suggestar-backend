class Listing < ApplicationRecord
    belongs_to :venue
    has_many :listing_categories
    has_many :categories, through: :listing_categories
end
