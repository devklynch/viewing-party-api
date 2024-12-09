# Viewing Part API - Solo Project

This is the base repo for the Viewing Party Solo Project for Module 3 in Turing's Software Engineering Program. 

## About this Application

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. Once completed, this application will collect relevant information about movies from an external API, provide CRUD functionality for creating a Viewing Party and restrict its use to only verified users. 

## Setup

1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`

Spend some time familiarizing yourself with the functionality and structure of the application so far.

Run the application and test out some endpoints: `rails s`

Routes
Top Rated Movies-returns top 20 rated movies
Locally: http://localhost:3000/api/v1/movies
Deployed: https://guarded-brook-90119-9dc05c55c14b.herokuapp.com/api/v1/movies

Movie Search-search for a movie by name by using a parameter
Locally: http://localhost:3000/api/v1/movies?query={YOUR_QUERY_HERE}
Deployed: https://guarded-brook-90119-9dc05c55c14b.herokuapp.com/api/v1/movies/?query={QUERY_NAME_SEARCH}

Movie Details-get details on the movie,cast, and reviews
Locally: http://localhost:3000/api/v1/movies/{MOVIE_ID}
Deployed: https://guarded-brook-90119-9dc05c55c14b.herokuapp.com/api/v1/movies/{MOVIE_ID}

Create a Viewing Party-create a viewing party and invite other users
http://localhost:3000/api/v1/viewing_parties/{USER_ID_OF_HOST}
and then in the body add this:
{
    "name": "Name of Viewing Party",
    "start_time": "2025-02-02 10:30:00",
    "end_time": "2025-02-02 14:30:00",
    "movie_id": 278, #Get the movie ID and title from TMDB using movie search
    "movie_title": "The Shawshank Redemption",
    "invitees": [1,2] #User IDs of invitees
}

Invitee IDs all need to be valid or you will receive an error

Add another invitee to an existing viewing party
Locally: http://localhost:3000/api/v1/viewing_parties/add_attendee/{VIEWING_PARTY_ID}
And then in the body adding the invitee(s)
{
  "invitees_user_id": [1] #for multiple [1,2,3]
}

Get User details-see their user info and the viewing parties they hosted and were invited to
Locally: http://localhost:3000/api/v1/users/{USER_ID}
Deployed: https://guarded-brook-90119-9dc05c55c14b.herokuapp.com/api/v1/movies/users/{USER_ID}