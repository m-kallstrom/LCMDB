class MoviesController < ApplicationController

  before_action :redirect_unregistered_users, only: [:confirm, :new, :create, :destroy], unless: -> { current_user }

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
    if movie_data["Response"] == "false"
      @errors = ["Sorry, couldn't find that one.", "Computers are dumb sometimes.", "Try getting the exact title from IMDB.", "This uses free software so you get what you pay for.", "Hit the back button or try entering it manually."]
      @movie = Movie.new
      render 'confirm'
    elsif movie_data["Ratings"][0] == nil
      imdb = "not available"
      rt = "not available"
    elsif movie_data["Ratings"][1] == nil
      rt = "not available"
      imdb = movie_data["Ratings"][0]["Value"]
    else
      imdb = movie_data["Ratings"][0]["Value"]
      rt = movie_data["Ratings"][1]["Value"]
    end
    @movie = Movie.new(title: movie_data["Title"], runtime: movie_data["Runtime"], year: movie_data["Year"], plot: movie_data["Plot"], actors: movie_data["Actors"], imdb_rating: imdb, rotten_tomatoes_rating: rt, production: movie_data["Production"] )
      if @movie
        render 'confirm'
      else
        @errors = @movie.errors.full_messages
        render 'new'
      end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie
    else
      @errors = @movie.errors.full_messages
      render 'confirm'
    end
  end

  def index
    if params[:sort_by] == "Title"
      @movies = Movie.order(:title).page params[:page]
      @sort_by = "Lorenzini Rating"
      @sorting_by = "Title"
    else
      @movies = Movie.order(lorenzini_rating: :desc).page params[:page]
      @sorting_by = "Lorenzini Rating"
      @sort_by = "Title"
    end
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    @rating = Rating.new
  end

  def search
    @movies = Movie.where("title ILIKE ?" , "%#{params[:request]}%")
    if @movies.empty?
      flash[:notice] = "Sorry, can't find any movies by that title. Here are all the titles alphabetically in one list. You can try using the Find shortcut on your keyboard."
      @movies = Movie.order(:title)
      @sort_by = "Lorenzini Rating"
      @sorting_by = "Title"
    else
      @sort_by = "Lorenzini Rating -- This will show all movies"
      @sorting_by = "Title"
    end
  end

  def destroy
    if admin_user
      @movie = Movie.find_by(id: params[:id])
      @movie.destroy
      redirect_to movies_path
    else
      flash[:notice] = "This is an admin function. How did you even get here?"
      redirect_to login_path
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:authenticity_token, :title, :year, :production, :actors, :plot, :runtime, :imdb_rating, :rotten_tomatoes_rating)
    end

    def redirect_unregistered_users
      flash[:notice] = "You must be logged in to create a movie. Please register or log into your account."
      redirect_to '/login'
    end

end
