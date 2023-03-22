Rails.application.routes.draw do
  devise_for :users
  resources :events

  resources :users, only: %i[show]

  root "events#index"
end
