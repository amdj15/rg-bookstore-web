Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'orders' => 'orders#index'

  devise_for :customers, path: "auth", :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :customers, only: [:create]
  resources :authors, only: [:show, :index]

  resources :categories, only: [:show, :index] do
    resources :books, only: [:show] do
      member do
        get "review"
        post "create_review"
      end
    end
  end

  delete 'categories/:category_id/books/:book_id/review/:id' => 'ratings#destroy', as: 'destroy_review'

  root "books#all"
end
