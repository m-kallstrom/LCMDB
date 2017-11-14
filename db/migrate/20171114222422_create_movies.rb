class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|

      t.string :title
      t.string :year
      t.string :runtime
      t.string :plot
      t.string :actors
      t.string :imdb_rating
      t.string :rotten_tomatoes_rating


      t.timestamps
    end
  end
end
