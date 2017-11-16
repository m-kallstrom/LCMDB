class MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def confirm
    title = movie_params[:title]
    title = title.split(" ").join('+')
    key = ENV['OMDB_KEY']
    require 'open-uri'
    if movie_params[:year].empty?
      json = open("http://www.omdbapi.com/?apikey=#{key}&t=#{title}&plot=full").read
    else
      year = movie_params[:year]
      json = open("http://www.omdbapi.com/?apikey=#{key}&t=#{title}&y=#{year}&plot=full").read
    end
    movie_data = JSON.parse(json)
    if json.include?("Movie not found!")
      @errors = ["Sorry, couldn't find that one.", "Computers are dumb sometimes.", "Try getting the exact title from IMDB.", "This uses free software so you get what you pay for.", "Hit the back button or try entering it manually."]
      @movie = Movie.new
      render 'confirm'
    elsif movie_data["Ratings"][1] == nil
      @movie = Movie.new(title: movie_data["Title"], runtime: movie_data["Runtime"], year: movie_data["Year"], plot: movie_data["Plot"], actors: movie_data["Actors"], imdb_rating: movie_data["Ratings"][0]["Value"], rotten_tomatoes_rating: "not available", production: movie_data["Production"] )
      if @movie
        render 'confirm'
      else
        @errors = @movie.errors.full_messages
        render 'new'
      end
    else
      @movie = Movie.new(title: movie_data["Title"], runtime: movie_data["Runtime"], year: movie_data["Year"], plot: movie_data["Plot"], actors: movie_data["Actors"], imdb_rating: movie_data["Ratings"][0]["Value"], rotten_tomatoes_rating: movie_data["Ratings"][1]["Value"], production: movie_data["Production"] )
      if @movie
        render 'confirm'
      else
        @errors = @movie.errors.full_messages
        render 'new'
      end
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie
    else
      @errors = @movie.errors.full_messages
      redirect_to new_movie_path
    end
  end

  def index
    if params[:sort_by] == "Title"
      @movies = Movie.order(:title).page params[:page]
      @sort_by = "Lorenzini Rating"
      @sorting_by = "Title"
    else
      @movies = Movie.order(:lorenzini_rating).page params[:page]
      @sorting_by = "Lorenzini Rating"
      @sort_by = "Title"
    end
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    @rating = Rating.new
  end

  def search
    @movies = Movie.where(params[:request])
  end

  private
    def movie_params
      params.require(:movie).permit(:authenticity_token, :title, :year, :production, :actors, :plot, :runtime, :imdb_rating, :rotten_tomatoes_rating)
    end

end
