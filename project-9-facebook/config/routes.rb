Rails.application.routes.draw do
  devise_for :users
  resources :friendships, only: %i[create update destroy index]
  resources :users, only: %i[index]

  root to: 'users#index'
end
