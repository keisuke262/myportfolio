# frozen_string_literal: true

class ApplicationController < ActionController::Base

    # ControllerからHelperのメソッドを使うことは
    # デフォルトではできないのでincludeする
    # logged_in?はHelperで定義している

    include SessionsHelper

    private

    def require_user_logged_in
        unless logged_in?
            redirect_to root_url
        end
    end


    # 投稿数を取得
    # これをレベルアップの基準に使う
    def counts(user)
        @count_posts = user.posts.count
        @count_followings = user.followings.count
        @count_followers = user.followers.count
        @count_favoriteposts = user.favoriteposts.count
    end
end

