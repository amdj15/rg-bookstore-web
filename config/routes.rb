Rails.application.routes.draw do
  root "books#all"

  resources :authors

  resources :categories do
    resources :books, only: [:index, :show, :edit, :update, :destroy]
  end

  resources :books, only: [:new, :create]
end
