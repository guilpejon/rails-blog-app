Rails.application.routes.draw do
  resources :bookings, only: %i[new show index create]

  resources :flights, only: [:index]

  root 'flights#index'
end
