# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: 'a@a.com', first_name: "Oliver", last_name: "Burt", password: "123", password_confirmation: "123")

Venue.create(name: "Flatiron", description: "Coding School", user_id: 1)

Address.create(venue_id: 1, address_identifier: "WeWork", street_number: 131, street_name: "Finsbury Pavement", address_type: "Office", governing_district: "London", minor_municipality: "Finsbury", major_municipality: "London", post_code: "EC2A 1NT", country: "United Kingdom")