class RatingsController < ApplicationController

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(params[:rating])
    if @rating.save
      redirect_to "/movies/#{@rating.movie_id}"
    else
      status 422
      @errors = @rating.errors.full_messages
      redirect_to new_rating_path
    end
  end


end
