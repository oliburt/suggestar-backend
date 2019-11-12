class User < ApplicationRecord
    has_many :venues
    has_many :listings, through: :venues
    has_many :reviews
    has_many :likes
    has_secure_password
    validates :email, uniqueness: true, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password_digest, presence: true

    def full_name
        "#{self.first_name} #{self.last_name}"
    end
end
