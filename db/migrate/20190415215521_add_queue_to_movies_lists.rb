class AddQueueToMoviesLists < ActiveRecord::Migration[5.2]
  def change
    add_column :movies_lists, :queue, :boolean
  end
end
