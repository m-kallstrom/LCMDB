class RatingsController < ApplicationController

  def create
    @rating = Rating.find_by(user_id: current_user.id, movie_id: ratings_params[:movie_id])
    @movie = Movie.find_by(id: ratings_params[:movie_id])
    if @rating
      @rating.update_attributes(value: ratings_params[:value], review: ratings_params[:review])
      if request.xhr?
        render partial: "/partials/ratings", layout: false, locals: {movie: @movie}
      else
        redirect_to "/movies/#{@rating.movie_id}"
      end
    else
      @rating = Rating.new(ratings_params)
      if @rating.save
        if request.xhr?
          render partial: "/partials/ratings", layout: false, locals: {movie: @movie}
        else
          redirect_to "/movies/#{@rating.movie_id}"
        end
      else
        if request.xhr?
          render partial: "/partials/errors", layout: false, locals: {errors: @errors}
        else
          flash[:notice] = @rating.errors.full_messages
          redirect_back
        end
      end
    end
  end

  def index
    @movie = Movie.find_by(id: params[:id])
    if @movie
      render partial: "/partials/lorenzini_rating", layout: false
    else
      flash[:notice] = @movie.errors.full_messages
      redirect_back
    end
  end

  private
    def ratings_params
      params.require(:rating).permit(:movie_id, :user_id, :review, :value, :authenticity_token)
    end

end
