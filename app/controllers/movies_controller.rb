class MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def confirm
    #make the request
    #initialize a new movie based on the info
    #display that info to the user and ask for confirmation that it's correct
      #if yes, then send it off to the create route
      #if no, then go back to the new route to do it again
  end

  def create
    @movie = Movie.new(params[:movie])
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
  end

  def search
    @movies = Movie.search(params[:request])
  end

end
