# Suggestar

Suggestar is an application built with two goals in mind. The first is for it to serve as a platform for people to discover 'suggestions' for events/places/activities based on the time and the users proximity. When a user opens up the application the home page will give them a scrollable stream of 'listings' (posted by other users) that may be of interest for them to go to. They can filter these listings by category and also click on the map tab to see markers of each listing at their venue's location. The user can view informational pages about each listing and their specified venue. If a user creates an account they can also leave 'likes' on a listing and reviews on a venue.

The second goal is to allow businesses that involve providing a service of some kind at some venue to be able to post listings of what service/promotion/event they are running at specific time. The goal would be to reach new customers who may be within the proximity of their venue. A person who uses suggestar for this purpose can create an account and setup informational pages about their venues and post listings for any of their venues that will appear on the home stream to any users in the correct proximity and on the correct day. This user can also update and delete any listings and venues they have created.
This repo is only for the back end of the application. You can find the front-end here: [Frontend-Repo](https://github.com/oliburt/suggestar)



## Prerequisites

This was built on macOS.

In order to run this project on your own machine you will need first need Ruby and Rails installed. (This was built with Ruby v.2.6.3p62 and Rails v.6.0.1)

You can download and find documentation about the Ruby programming language [here](https://www.ruby-lang.org/en/documentation/)

To download and find documentation about the Rails Framework you can do so [here](https://rubyonrails.org/). ( Rails is built on Ruby so download Ruby first)

You will also need [postgres](https://www.postgresql.org/) installed locally on your machine to setup the database.

Once you have Ruby and Rails installed you can fork and clone this project to your local machine.

After cloning the project open the main project directory in the terminal and run:
```
$ bundle install
```
to install all gem dependencies.

Then run:
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
to create the database and its schema in PostGres and seed the category data.

Then lastly you can run: 
```
$ rails s
```
to spin up the development server on your localhost.


*In order to get the JWT authentication to work you will need to create an environment variable called 'RAILS_SECRET'. In this project I have used the figaro gem to easily manage setting this up. In the terminal run:*
```
$ bundle exec figaro install
```
*This will create the file /config/application.yml and add it to your .gitignore file. Then you can write and save in application.yml:*

```
RAILS_SECRET: "[YOUR_SECRET_HERE]"
```
*Then you can access this variable through: ENV['RAILS_SECRET']*


## Main Features

This project has been setup to serve data to the front-end in JSON format. The API structure follows REST-ful conventions.

### Model setup

For this project there are seven models so far.

User model - first_name:string, last_name:string, email:string, password_digest:string (password hash managed by bcrypt gem).

Category Model - name:string.

Venue Model - name:string, description:string, latitude:float, longitude:float, place_id:string (for google places api), user_id:integer(foreign key), address:string (from google places api), image_url:string, image_public_id:string (images hosted at cloudinary)

Review Model - user_id:integer (foreign key), venue_id:integer (foreign key), rating:integer (1-5), content:string.

Listing Model - title:string, description:string, ticket_url:string, age_restriction:string, begin_datetime:datetime, end_datetime:datetime, venue_id:integer (foreign key)

ListingCategory Model - listing_id:integer, category_id:integer (this is purely a join table)

Like Model - user_id:integer (foreign key), listing_id:integer (foreign key).


Users have many likes.
Users have many reviews.
Users have many venues.
Users have many listings, through venues

Venues have many listings.
Venues belong to a user.
Venues have many reviews.

Reviews belong to a venue.
Reviews belong to a user.

Listings belong to a venue.
Listings have many likes.
Listings have many listing_categories
Listings have many categories, through listing_categories

Likes belong to a user.
Likes belong to a listing.

Categories have many listing_categories
Categories have many listings, through listing_categories

ListingCategories belong to a category
ListingCategories belong to a listing

### Controllers

There is a controller for each of the models to deal with incoming requests plus an Auth-Controller for managing user validations and login/logout actions as well as the initial fetch of data.

### Auth and Validation

JSON Web Tokens (JWT) has been used to encrypt the user_id when a session begins and is stored in local-storage on the client's machine. Every subsequent request sent by the client includes this token in its headers and it is then decoded and if the web token is valid (user is found) then the appropriate action is taken. (In the future I want to switch from storing it in local storage to an HTTP-only cookie for extra securtiy measures)


## Technology Stack

### Backend

- [Ruby](https://www.ruby-lang.org/en/documentation/)
- [Rails](https://rubyonrails.org/) (Initialized with 'rails new' with '--api' flag)
- [Postgres](https://www.postgresql.org/)
- Active-Model-Serializers for data serialization
- Bcrypt for password authentication
- Rack-Cors for CORS
- JWT for user Auth (stored in an HTTP-Only Cookie)
- Figaro for managing secret env variables.

### Frontend - [Frontend-Repo](https://github.com/oliburt/suggestar)

- JavaScript
- HTML
- CSS
- [Node.js]((https://nodejs.org/en/)) + NPM
- React (This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app))
- [Redux](https://redux.js.org/) + [Redux Devtools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en)
- [React Router Dom](https://reacttraining.com/react-router/web/guides/quick-start)
- Google Maps API for showing the map and displaying venue locations with markers.
- Google Places API for autofilling the address in the new venue form as well as retrieving and maintaing geolocation data
- [React Google Maps Package](https://tomchentw.github.io/react-google-maps/)
- [React Places Autocomplete Package](https://github.com/hibiken/react-places-autocomplete)
- [React DatePicker Package](https://reactdatepicker.com/)
- [React Star Rating Component Package](https://github.com/voronianski/react-star-rating-component)
- Styling done with [Semantic-UI-React](https://react.semantic-ui.com/)

## Future Development Plans

- More filter, sort and search options. Eg. sort by likes or search by venue.
- A testing suite
- Refactor controllers to seperate concerns on inital call and user validation.
- Add action cable for websockets to send broadcast new listings and likes and reviews.

## Author

Oliver Burt