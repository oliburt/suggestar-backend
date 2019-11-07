# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all

category_list = [
    "Music",
    "Food",
    "Drinks",
    "Pub Quiz",
    "Live Music",
    "Market",
    "Education",
    "Sport",
    "Festival",
    "Corporate",
    "Business",
    "Technology",
    "Social",
    "Karaoke",
    "Promotion",
    "Deal",
    "Free",
    "Health",
    "Fashion",
    "Art",
    "Exhibition",
    "Meetup",
    "Dating",
    "Well-Being",
    "Comedy",
    "Film",
    "Theatre",
    "Performing Arts"
]

category_list.each do |name|
    Category.create(name: name)
end