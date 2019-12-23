Rails.application.routes.draw do
	devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update]
  get "users/:id" => "users#show", as: :mypage

  #フォローフォロワー機能
  post "users/:id/follow" => "users#follow", as: :follow_users
  post "users/:id/unfollow" => "users#unfollow", as: :unfollow_users

  resources  :notes do
    collection do
    get "tags"
    get "search"
    get "youtube"
    get "new_list"
    post "new"
    post "create", as: :create
    end
  	resource :favorites, only: [:create, :destroy]
  	resources :note_comments, only: [:create, :destroy]
  end

  resources :notebooks, only: [:index, :show, :create, :update, :destroy, :edit]

  resources :notebook_notes, only: [:create, :destroy]

  root to: 'notes#index'
end
