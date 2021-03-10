class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    # validates :password, presence: true, length: { minimum: 8 }
    # validates :goal, presence: true, length: { maximum: 255 }
    # validates :achieve, presence: true, length: { maximum: 255 }
    # モデルの関連づけ(UserとImage)
    # カラムの名前をmount_uploaderに指定
    mount_uploader :image, ImageUploader
    # password_digestカラムを用意し、
    #モデルファイルにhas_secure_passwordを記述すれば
    #ログイン認証が可能になる
    has_secure_password
  
    # 一対多の関係を表現
    # これによって、user.postsであるUserが投稿した
    # post一覧を取得することができる
    has_many :posts
    has_many :relationships
    # followingsモデルはないため、なんの情報を取得するかを
    # 後に追加情報として補足している
    # sourceで中間テーブルのカラムの何を参照すべきidであるかを指定している
    # この記述によって、user.followingsメソッドが使えるようになり
    # 自分がフォローしている人たちを取得できるようになる
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    # この記述によって、user.followersで自分をフォローしている人たちを取得できる
    has_many :followers, through: :reverses_of_relationship, source: :user
  
    has_many :favorites, dependent: :destroy     
    has_many :favoriteposts, through: :favorites, source: :post
    # follow, unfollowするとは、中間テーブルのレコードを保存 or 削除すること
    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
      end 
    end
  
    def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
    end
  
    def following?(other_user)
      self.followings.include?(other_user)
    end
  
    def feed_posts
      Post.where(user_id: self.following_ids + [self.id])
    end
  
    def favorite(post)
      self.favorites.find_or_create_by(post_id: post.id)
    end
  
    def unfavorite(post)
      favorite = self.favorites.find_by(post_id: post.id)
      favorite.destroy if favorite
    end
  
    def favoriteing?(post)
      self.favoriteposts.include?(post)
    end
  end

  #検索機能のため
  def self.search(search)
    if search != ""
      User.where( 'name Like(?)', "%#{search}%" )
    else
      User.all
    end
  end