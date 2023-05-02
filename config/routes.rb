Rails.application.routes.draw do

  resources :users, only: [:create]
  root 'home#index'
  get '/', to: 'home#index', as: '/'
  get 'register', to: 'register#index', as: 'register'
  get 'login', to: 'login#index', as: 'login'

  #POST
  post 'users/create', to: 'users#create', as: 'users/create'
  post 'login/create', to: 'login#create', as: 'login/create'
  post 'login/destroy', to: 'login#destroy', as: 'login/destroy'
end
