
class Relationship < ApplicationRecord

  # モデル名_idとなっているuser_idはRailsの方で
  # 自動的にUserを参照するようになっている
  # follow_idはモデル名_idとなっていないので
  # class名を追加する必要がある
  # もしclass名を追加しなかったらfollowモデルを参照
  # することになり、そんなモデルはないといったERRORが出る
  belongs_to :user
  belongs_to :follow, class_name: 'User'
end


