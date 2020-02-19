class AddIsActiveToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :is_active, :boolean, default: false
  end
end
