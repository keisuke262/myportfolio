Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'toppages#index'
  resources :inquiries, only: [:index, :new, :create]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #ActionMailerの内容を開発(ローカル)環境で確認できるようにするための設定
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get 'signup', to: 'users#new'
  get 'webapp-toppages', to: 'webapptoppages#index'

  post 'users/:id/followings' => 'users#followings'
  post 'users/:id/followers' => 'users#followers'
  post 'users/:id/favoriteposts' => 'users#favoriteposts'
  # post 'webapp-toppages' => 'webapptoppages#index'


  # resourcesにはmemberとcollectionという
  # URLを深堀するオプションを付与することができる
  # memberとcollectionの違いはUserを:idで特定する必要のある
  # pageであるかどうか、idで特定必要ならmemberを使用
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do 
      get :followings
      get :followers
    end
  end

  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :favoriteposts
    end
  end

  resources :posts, only: [:create, :destroy, :edit, :update]
  # Userがfollow, unfollowできるために必要なRouting
  # なぜならfollow, unfollowするとは中間テーブルを保存 or 削除することであるから
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]



end


