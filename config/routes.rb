Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :customers, path: "auth", :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :customers, only: [:create]

  resources :authors, only: [:show, :index] do
    resources :ratings, only: [:new, :create, :destroy]
  end

  resources :categories, only: [:show, :index] do
    resources :books, only: [:show] do
      resources :ratings, only: [:new, :create, :destroy]
    end
  end

  resources :carts, only: [:index], as: "cart", path: "cart" do
    post :add, on: :collection
    put :update, on: :collection, as: "update"
    delete :clear, on: :collection
    delete ":item_id" => "carts#delete_item", on: :collection, as: "delete_item"
  end

  resources :orders, only: [:index, :show] do
    collection do
      get "checkout/:step" => "orders#checkout", as: "checkout"
      post "next_step"
    end
  end

  root "books#all"
end
