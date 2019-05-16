Rails.application.routes.draw do
  get 'relationships/create'

  get 'relationships/destroy'

  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
  end


  resources :items, only: [:new, :show]
  resources :ownerships, only: [:create, :destroy]
  
  get 'rankings/have', to: 'rankings#have'
  get 'rankings/want', to: 'rankings#want'

  resources :posts
end
