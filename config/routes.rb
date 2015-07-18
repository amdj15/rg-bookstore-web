Rails.application.routes.draw do
  get 'orders' => 'orders#index'

  devise_for :customers, path: "auth"
  root "books#all"

  # get 'auth/sign_in'
  # get 'auth/sign_out'
  # get 'auth/sign_up' => 'customers#new', as: 'new_customer'
  # post 'auth/authenticate'

  resources :customers, only: [:create]
  resources :authors

  resources :categories do
    resources :books, only: [:show, :edit, :update, :destroy]
  end

  resources :books, only: [:new, :create]
end
