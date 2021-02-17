class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content

      # これは実際のデータベース上では
      # user_idカラムとして存在し
      # そこにUserのidが保存される
      # foreign_keyは外部キー制約というもの
      # 外部キー制約は、間違ったデータをできるだけ排除する
      # ここではUSerとPostの接続関係を強化する
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
