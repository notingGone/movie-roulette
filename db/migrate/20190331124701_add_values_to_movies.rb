class AddValuesToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :tmdb_id, :integer
    add_column :movies, :homepage, :string
    add_column :movies, :popularity, :integer
    add_column :movies, :vote_average, :integer
  end
end
