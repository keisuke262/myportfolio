class RemoveAchieveFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :achieve, :string
  end
end
