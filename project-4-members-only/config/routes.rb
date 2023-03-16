Rails.application.routes.draw do
  resources :posts, only: %i[new create index]
  devise_for :users
  root to: "posts#index"
end
