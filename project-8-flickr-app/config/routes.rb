Rails.application.routes.draw do
  get 'photos', to: 'static_pages#photos'

  root 'static_pages#home'
end
