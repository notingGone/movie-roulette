class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :imdb_id
      t.string :title
      t.string :overview
      t.string :poster_path
      t.integer :runtime
      t.string :tagline

      t.timestamps
    end
  end
end
