Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'orders' => 'orders#index'

  devise_for :customers, path: "auth"

  root "books#all"

  resources :customers, only: [:create]
  resources :authors, only: [:show, :index]

  resources :categories, only: [:show, :index] do
    resources :books, only: [:show]
  end
end
