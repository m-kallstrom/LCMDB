class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|

      t.references :movie, null: false
      t.references :user, null: false
      t.integer    :value, null: false
      t.string     :review

      t.timestamps
    end
  end
end
