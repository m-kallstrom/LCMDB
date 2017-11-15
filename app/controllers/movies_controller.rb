class MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def confirm
    title = params[:title]
    title = title.split(" ").join('+')
    key = ENV['OMDB_KEY']
    p key
    require 'open-uri'
    # @response = open("http://www.omdbapi.com/?apikey=#{key}&t=#{title}&plot=full").read
    # puts @response
    render 'confirm'
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
    @rating = Rating.new
  end

  def search
    @movies = Movie.search(params[:request])
  end

  # private
  #   def movie_params
  #     params.require(:movie).permit(:username, :password)
  #   end

end
