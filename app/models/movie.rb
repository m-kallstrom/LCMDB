class Movie < ApplicationRecord
  has_many :ratings
  has_many :viewers, through: :ratings, source: 'user'

  validates_presence_of :title
end
