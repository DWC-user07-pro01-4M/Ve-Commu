Rails.application.routes.draw do

  # 管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    #homes
    root to: "homes#top"
    #end_users
    resources :end_users, only: [:index, :show, :edit, :update]
    #tags
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    #comments
    resources :comments, only: [:index, :show, :edit, :update, :destroy]
    #order_items
    resources :order_items, only: [:update]
  end

  # 会員
  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
    #homes
    scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    #end_users
    resources :end_users, only: [:index, :show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdrawal'
        end
      end
    end

  namespace :public do
    #posts
    resources :posts, only: [:index, :show, :create, :edit, :update, :destroy]
    #bookmarks
    resources :bookmarks, only: [:index, :edit, :update, :destroy]
    #comments
    resources :comments, only: [:new, :index, :create, :destroy]
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end