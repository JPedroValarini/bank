Rails.application.routes.draw do

  resources :users, only: [:create]

  resources :accounts, only: [:create] do
    member do
      put :deposit
      put :withdraw
      put :transfer
    end
  end

  root 'home#index'
  get '/', to: 'home#index', as: '/'
  get 'register', to: 'register#index', as: 'register'
  get 'login', to: 'login#index', as: 'login'
  get 'teste', to: 'accounts#index', as: 'teste'
  
  #POST
  post 'accounts/create', to: 'accounts#create', as: 'accounts/create'
  post 'users/create', to: 'users#create', as: 'users/create'
  post 'login/create', to: 'login#create', as: 'login/create'
  post 'login/destroy', to: 'login#destroy', as: 'login/destroy'
end
