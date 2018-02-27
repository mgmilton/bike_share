Rails.application.routes.draw do
  root "welcome#index"

  namespace :admin do
    resources :conditions, only: [:new, :create, :edit, :update, :destroy]
    resources :stations, except: [:index, :show], param: :name
    resources :trips, only: [:new, :edit, :update, :destroy, :create]
    resources :items, except: [:destroy, :show], path: 'bike-shop'
    resources :orders, only: [:index, :show, :update], path: 'dashboard'
  end

  resources :conditions, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :stations, only: [:index]
  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:create, :show]
  resources :carts, only: [:create, :show]
  patch "/remove_item", to: "carts#remove_item"
  patch "/decrease", to: "carts#decrease"
  patch "/increase", to: "carts#increase"
  resources :items, path: 'bike-shop', only: [:show, :index]

  get "/dashboard", to: "users#dashboard"
  get "/cart", to: "carts#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/trips-dashboard", to: "trips_dashboard#index"
  get "/weather-dashboard", to: "weather_dashboard#index"
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/map', to: "conditions#map"

  get '/stations-dashboard', to: 'stations#dashboard'

  get '/:name', to: 'stations#show'
end
