class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: :destroy
  
  def index
    if logged_in?
    # form_with用
    # 投稿するフォームを設置するから
    # @postにカラのインスタンスを代入しておく
    # form_with(model: @post)として使用する
      @post = current_user.posts.build
      @q = Post.ransack(params[:q])
      @q.sorts = ['updated_at desc', 'id desc'] if @q.sorts.empty?
      @posts = @q.result(distinct: true)
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Your Post is sent'
      redirect_to posts_url
    else  
      @q = Post.ransack(params[:q])
      @q.sorts = ['updated_at desc', 'id desc'] if @q.sorts.empty?
      @posts = @q.result(distinct: true)
      flash.now[:danger] = 'Failed'
      render 'posts/index'
    end
  end

  def destroy
    # この@postはcorrect_userメソッドで取得したもの
    # つまりcorrect_userの時点でUserに紐づいた投稿を
    # 取得できていなければこのdestroyメソッドは実行されない
    @post.destroy
    flash[:success] = 'Your Post is deleted'
    # redirect_backはアクションが実行されたページに戻る
    # fallback_locationは保険的なもので、戻るべき
    # 場所が見つからない時に、戻る場所を指定するもの。
    redirect_to posts_url
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'Your Post is updated'
      redirect_to posts_url
    else
      flash.now[:danger] = 'Failed '
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def correct_user
    # 削除しようとしている投稿が本当に
    # 自分の投稿であるか確かめる
    # 他の人の投稿を勝手に消してしまえる設定はNG
    # もし自分のでなければdestroyアクションは実行せずに、
    # postsに戻るようにしている
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to posts_url
    end
  end
end



