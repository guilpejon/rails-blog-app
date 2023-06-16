Rails.application.routes.draw do
  devise_for :users
  resources :friendships, only: %i[create update destroy]
  resources :users, only: %i[index]

  root to: 'home#index'
end
