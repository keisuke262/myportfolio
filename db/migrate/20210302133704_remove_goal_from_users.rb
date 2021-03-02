class RemoveGoalFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :goal, :string
  end
end
