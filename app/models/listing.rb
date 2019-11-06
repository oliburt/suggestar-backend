class Listing < ApplicationRecord
    belongs_to :venue
    has_many :listing_categories
    has_many :categories, through: :listing_categories

    def within_correct_time
        ((self.begin_datetime.to_datetime >= DateTime.now && self.begin_datetime.to_datetime < 1.days.from_now ) || (self.begin_datetime.to_datetime < DateTime.now && self.end_datetime.to_datetime >= DateTime.now))
    end
end
