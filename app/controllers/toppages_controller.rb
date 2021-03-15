# frozen_string_literal: true

class ToppagesController < ApplicationController
  # controllerのデフォルト機能として、アクションの最後に
  # render :自身のアクション名を呼び出している
  # つまりcontrollerのアクションに対応するViewを呼び出す
  def index

    if logged_in?
      # form_with用
      # 投稿するフォームを設置するから
      # @postにカラのインスタンスを代入しておく
      # form_with(model: @post)として使用する
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    end
  end
end

