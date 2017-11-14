class User < ApplicationRecord

  has_many :ratings
  has_many :rated_movies, through: :ratings, source: 'Movie'

  has_secure_password

end
