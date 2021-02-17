class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|

      # t.referencesは別のテーブルを参照させるという意味
      t.references :user, foreign_key: true
      # follwテーブルではなく、userテーブルを参照させる
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      # ユーザが同じユーザを重複してフォローするのを防ぐ
      t.index [:user_id, :follow_id], unique: true
    end
  end
end

