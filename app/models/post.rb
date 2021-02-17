class Post < ApplicationRecord
  # 一対多の関係を表現
  # これによってUserの紐づけ無しではPostを保存できない
  # また、posts.userである投稿に紐づいたUserを取得できる
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :content, presence: true  #, length: { maximum: 500 }
end


