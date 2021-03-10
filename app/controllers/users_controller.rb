# frozen_string_literal: true


class UsersController < ApplicationController

  before_action :require_user_logged_in, only:[:index, :show, :edit, :followings, :followers]
  before_action :require_user_logged_in, only:[:index, :show, :edit, :favoritemicroposts]

  def index
    # ページネーションを適用させるためにpage(params[:page])をつけている
    @users = User.order(id: :desc).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
    if logged_in?
      # form_with用
      # index.html.erbに投稿するフォームを設置するから
      # @postにカラのインスタンスを代入しておく
      # form_with(model: @post)として使用する
      @post = current_user.posts.build
    end
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params1)

    if @user.save
      flash[:success] = 'Welcome to SPEnglish !'
      redirect_to login_path
    else
      flash.now[:danger] = 'Failed'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

def update
  @user = User.find(params[:id])

  if @user.update(user_params)
    flash[:success] = 'Your profile is updated'
    redirect_to user_url
  else
    flash.now[:danger] = 'Failed '
    render :edit
  end
end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
    if logged_in?
      # form_with用
      # index.html.erbに投稿するフォームを設置するから
      # @postにカラのインスタンスを代入しておく
      # form_with(model: @post)として使用する
      @post = current_user.posts.build
    end
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
    if logged_in?
      # form_with用
      # index.html.erbに投稿するフォームを設置するから
      # @postにカラのインスタンスを代入しておく
      # form_with(model: @post)として使用する
      @post = current_user.posts.build
    end
  end

  def favoriteposts 
    @user = User.find(params[:id])
    @favoriteposts = @user.favoriteposts.page(params[:page])
    counts(@user)
    if logged_in?
      # form_with用
      # index.html.erbに投稿するフォームを設置するから
      # @postにカラのインスタンスを代入しておく
      # form_with(model: @post)として使用する
      @post = current_user.posts.build
    end
  end

  #検索機能のため
  def search
    @user = User.search(params[:search])
  end

  private

  def user_params
    params.require(:user).permit(:name, :subscription, :movie, :goal, :image)
  end

  def user_params1
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end

