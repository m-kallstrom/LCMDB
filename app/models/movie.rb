class Movie < ApplicationRecord
  has_many :ratings
  has_many :viewers, through: :ratings, source: 'user'

  validates_presence_of :title

  def lorenzini_rating
    self.ratings.sum(:value)
  end

  def short_summary
    line = self.plot.split(". ")
    if line.length >= 2
      line[0] + ". " + line[1] + "."
    else
      line
    end
  end

end
