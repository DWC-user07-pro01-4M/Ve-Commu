Rails.application.routes.draw do

  namespace :public do
    get 'bookmarks/index'
    get 'bookmarks/show'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get 'comments/index'
    get 'comments/show'
    get 'comments/edit'
  end
  namespace :admin do
    get 'tags/index'
    get 'tags/edit'
  end
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  # 管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # 会員
  devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
