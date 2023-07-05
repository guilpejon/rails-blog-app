Rails.application.routes.draw do
  devise_for :users
  resources :friendships, only: %i[create update destroy index]
  resources :users, only: %i[index update]
  resources :posts, only: %i[index create show]
  resources :comments, only: %i[create destroy]
  resource :likes, only: %i[create destroy]

  get 'profile', to: 'users#profile'

  root to: 'posts#index'
end
