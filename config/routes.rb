Rails.application.routes.draw do

  # 管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    #homes
    root to: "homes#top"
    #end_users
    resources :end_users, only: [:index, :edit, :update]
    #tags
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    #comments
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
  #homes
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    #end_users
    resources :end_users, only: [:show, :edit, :update] do
      collection do
        get "unsubscribe"
        patch "withdrawal"
      end
      # bookmark
      member do
        get :bookmark
      end
    end
      #posts
      resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
        #comments
        resources :comments, only: [:create, :destroy]
        #bookmarks
        resources :bookmarks, only: [:create, :destroy]
      end
      #search
      get "search" => "posts#search"

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end