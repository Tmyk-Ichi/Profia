Rails.application.routes.draw do
	devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update]
  get "users/:id" => "users#show", as: :mypage

  get "notes/result" => "notes#result", as: :result

  resources  :notes do
  	resource :favorites, only: [:create, :destroy]
  	resources :note_comments, only: [:create, :destroy]
  end

  resources :notebooks, only: [:index, :show, :create, :update, :destroy, :edit]

  resources :notebook_notes, only: [:create, :destroy]

  root to: 'notes#index'
end
