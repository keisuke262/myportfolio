class AddWorkToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :work, :string
  end
end
