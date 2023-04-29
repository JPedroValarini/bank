Rails.application.routes.draw do
  resources :users, only: [:create]
  get 'users/create'
  root 'home#index'
end
