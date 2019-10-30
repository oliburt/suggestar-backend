class Listing < ApplicationRecord
    has_many :listing_categories
    has_many :categories, through: :listing_categories
end
