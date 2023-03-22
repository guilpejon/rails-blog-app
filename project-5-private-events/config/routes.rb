Rails.application.routes.draw do
  devise_for :users
  resources :events do 
    post 'attend', to: 'attendances#create'
  end

  resources :users, only: %i[show]

  root "events#index"
end
