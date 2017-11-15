class MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def confirm
    title = params[:title]
    title = title.split(" ").join('+')
    key = ENV['OMDB_KEY']
    require 'open-uri'
    json = open("http://www.omdbapi.com/?apikey=#{key}&t=#{title}&plot=full").read
    movie_data = JSON.parse(json)
    if movie_data.include?("Movie not found!")
      status 422
      @errors = ["Sorry, couldn't find that one.", "Computers are dumb sometimes.", "Try getting the exact title from IMDB.", "This uses free software so you get what you pay for.", "Hit the back button or try entering it manually."]
      @movie = Movie.new
      render 'confirm'
    else
      @movie = Movie.new(title: movie_data["Title"], runtime: movie_data["Runtime"], year: movie_data["Year"], plot: movie_data["Plot"], actors: movie_data["Actors"], imdb_rating: movie_data["Ratings"][0]["Value"], rotten_tomatoes_rating: movie_data["Ratings"][1]["Value"], production: movie_data["Production"] )
      if @movie
        render 'confirm'
      else
        status 422
        @errors = ["Not sure what happened there.", "Try again."]
        render 'new'
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie
    else
      status 422
      @errors = @movie.errors.full_messages
      redirect_to new_movie_path
    end
  end

  def index
    @movies = Movie.order(:title)
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    @rating = Rating.new
  end

  def search
    @movies = Movie.search(params[:request])
  end

  private
    def movie_params
      params.require(:movie).permit(:authenticity_token, :title, :year, :production, :actors, :plot, :runtime, :imdb_rating, :rotten_tomatoes_rating)
    end

end
