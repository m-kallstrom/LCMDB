class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|

      t.references :movie
      t.references :user
      t.integer    :value
      t.string     :review

      t.timestamps
    end
  end
end
