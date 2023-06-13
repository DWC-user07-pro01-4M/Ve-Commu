Rails.application.routes.draw do
  # 管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :end_users, only: [:index, :edit, :update]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :comments, only: [:index, :show, :destroy]
  end




  # 会員
  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # ゲストログイン
  devise_scope :end_user do
    post "end_user/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"

    resources :end_users, only: [:show, :edit, :update] do
      collection do
        get "unsubscribe"
        patch "withdrawal"
      end

      member do
        get :bookmark
      end
    end

    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :bookmarks, only: [:create, :destroy]
    end

    get "search" => "posts#search"
    
    post "like/:id" => "likes#create", as: "create_like"
    delete "like/:id" => "likes#destroy", as: "destroy_like"
  end

  # お問い合わせ用ルーティング
  resources :contacts, only: [:new, :create] do
    get "/thanks" => "contacts#thanks"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end