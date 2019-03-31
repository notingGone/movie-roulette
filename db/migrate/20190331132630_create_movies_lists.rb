class CreateMoviesLists < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_lists do |t|
      t.integer :movie_id
      t.integer :list_id

      t.timestamps
    end
  end
end
