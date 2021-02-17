class Favorite < ApplicationRecord
  # どちらともモデル名_idとなっているので、
  # 自動的にUserとPostを参照する
  belongs_to :user
  belongs_to :post
end

