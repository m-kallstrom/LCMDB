class User < ApplicationRecord

  has_many :ratings, dependent: :destroy
  has_many :rated_movies, through: :ratings, source: 'movie'

  has_secure_password

  validates :username, presence: true, uniqueness: true

end
