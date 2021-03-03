class RemoveWorkFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :work, :string
  end
end
