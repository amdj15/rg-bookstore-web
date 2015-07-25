Rails.application.routes.draw do
  get 'omniauth_callbacks/facebook'

  namespace :customer do
    get 'omniauth_callbacks/facebook'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'orders' => 'orders#index'

  devise_for :customers, path: "auth", :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root "books#all"

  resources :customers, only: [:create]
  resources :authors, only: [:show, :index]

  resources :categories, only: [:show, :index] do
    resources :books, only: [:show]
  end
end
