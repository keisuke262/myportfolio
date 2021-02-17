class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
      # user_idとpost_idのペアが重複しないように
      t.index [:user_id, :post_id], unique: true
    end
  end
end

