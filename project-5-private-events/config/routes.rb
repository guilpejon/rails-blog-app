Rails.application.routes.draw do
  devise_for :users
  resources :events do 
    post 'attend', to: 'attendances#create'
    delete 'stop_attending', to: 'attendances#destroy'
  end

  resources :users, only: %i[show]

  root "events#index"
end
