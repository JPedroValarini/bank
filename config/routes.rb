Rails.application.routes.draw do

  resources :users, only: [:create]
  root 'home#index'
  get '/', to: 'home#index', as: '/'
  get 'register', to: 'register#index', as: 'register'

  #POST
  post 'users/create', to: 'users#create', as: 'users/create'
end
