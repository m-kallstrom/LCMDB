class RatingsController < ApplicationController

  def create
    @rating = Rating.find_by(user_id: current_user.id, movie_id: ratings_params[:movie_id])
    if @rating
      if @rating.value == ratings_params[:value]
        flash[:notice] = "Review updated!"
        @rating.update_attributes(review: ratings_params[:review])
      else
        @rating.update_attributes(value: ratings_params[:value], review: ratings_params[:review])
      end
      redirect_to "/movies/#{@rating.movie_id}"
    else
      @rating = Rating.new(ratings_params)
      if @rating.save
        redirect_to "/movies/#{@rating.movie_id}"
      else
        flash[:notice] = @rating.errors.full_messages
        redirect_back
      end
    end
  end

  private
    def ratings_params
      params.require(:rating).permit(:movie_id, :user_id, :review, :value, :authenticity_token)
    end

end
