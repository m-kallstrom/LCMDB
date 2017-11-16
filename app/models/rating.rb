class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_presence_of :user, :movie

  validates_uniqueness_of :user, scope: :movie

  after_save :update_movie_rating

  def update_movie_rating
    @movie = Movie.find(self.movie.id)
    @movie.update_attributes(lorenzini_rating: @movie.ratings.sum(:value))
  end

end
