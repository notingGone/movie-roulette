class AddAdultToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :adult, :boolean
  end
end
