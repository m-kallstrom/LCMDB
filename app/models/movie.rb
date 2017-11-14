class Movie < ApplicationRecord
  has_many :ratings
  has_many :viewers, through: :ratings, source: 'User'

end
