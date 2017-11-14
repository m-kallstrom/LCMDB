# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "Marla", password: "password")

movie = {"Title":"Grumpy Cat's Worst Christmas Ever","Year":"2014","Rated":"G","Released":"29 Nov 2014","Runtime":"85 min","Genre":"Adventure, Comedy","Director":"Tim Hill","Writer":"Tim Hill, Jeff Morris","Actors":"Grumpy Cat, Megan Charpentier, Daniel Roebuck, Russell Peters","Plot":"Grumpy Cat is a lonely cat living in a mall pet shop. Because she never gets chosen by customers, she develops a sour outlook on life...until one day during the holidays, a very special 12-...","Language":"English","Country":"USA","Awards":"4 nominations.","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMzIwNDMyNzkzNV5BMl5BanBnXkFtZTgwNzE1OTI2MzE@._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"5.1/10"},{"Source":"Rotten Tomatoes","Value":"30%"}],"Metascore":"N/A","imdbRating":"5.1","imdbVotes":"1,819","imdbID":"tt3801438","Type":"movie","DVD":"22 Dec 2014","BoxOffice":"N/A","Production":"Lifetime Movie Network","Website":"http://www.mylifetime.com/movies/grumpy-cats-worst-christmas-ever","Response":"True"}

Movie.create(title: movie[:Title], runtime: movie[:Runtime], year: movie[:Year], plot: movie[:Plot], actors: movie[:Actors], imdb_rating: movie[:Ratings][0][:Value], rotten_tomatoes_rating: movie[:Ratings][1][:Value], production: movie[:Production] )

Rating.create(user_id: 1, movie_id: 1, value: 1)