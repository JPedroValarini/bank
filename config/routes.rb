Rails.application.routes.draw do

  resources :users, only: [:create]

  resources :accounts, only: [:create] do
    member do
      put :deposit
      put :withdraw
      put :transfer
    end
  end

  root 'accounts#index'
  get 'register', to: 'register#index', as: 'register'
  get 'login', to: 'login#index', as: 'login'
  get 'account', to: 'accounts#index', as: 'account'
  
  #POST
  post 'accounts/create', to: 'accounts#create', as: 'accounts/create'
  post 'users/create', to: 'users#create', as: 'users/create'
  post 'login/create', to: 'login#create', as: 'login/create'
  post 'login/destroy', to: 'login#destroy', as: 'login/destroy'
end
