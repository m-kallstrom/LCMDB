class RatingsController < ApplicationController

  def create
    @rating = Rating.new(ratings_params)
    if @rating.save
      redirect_to "/movies/#{@rating.movie_id}"
    else
      status 422
      @errors = @rating.errors.full_messages
      redirect_to new_rating_path
    end
  end

  private
    def ratings_params
      params.require(:rating).permit(:movie_id, :user_id, :review, :value, :authenticity_token)
    end

end
