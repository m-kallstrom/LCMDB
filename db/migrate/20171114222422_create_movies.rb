class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|

      t.string  :title, null: false
      t.string  :year, null: false
      t.string  :runtime
      t.string  :production
      t.text    :plot, null: false
      t.text    :actors
      t.string  :imdb_rating
      t.string  :rotten_tomatoes_rating
      t.integer :lorenzini_rating, default: 0


      t.timestamps
    end
  end
end
