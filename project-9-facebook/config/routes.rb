Rails.application.routes.draw do
  devise_for :users
  resources :friendships, only: %i[create update destroy index]
  resources :users, only: %i[index]
  resources :posts, only: %i[index create]

  root to: 'posts#index'
end
