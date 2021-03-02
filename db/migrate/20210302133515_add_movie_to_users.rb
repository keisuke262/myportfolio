class AddMovieToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :movie, :string
  end
end
