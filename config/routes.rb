Rails.application.routes.draw do
  root "welcome#index"

  namespace :admin do
    resources :conditions, only: [:new, :create, :edit, :update, :destroy]
    resources :stations, except: [:index, :show], param: :name
    resources :trips, only: [:new, :edit, :update, :destroy, :create]
    resources :items, only: [:create]
    resources :users, only: [:show]
    get 'bike-shop/new', to: 'items#new'
  end

  resources :carts, only: [:create, :destroy]
  resources :conditions, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :stations, only: [:index]
  resources :users, only: [:new, :create, :edit, :update]

  get "/dashboard", to: "users#show"
  get "/carts", to: "carts#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/trips-dashboard", to: "trips_dashboard#index"
  get "/weather-dashboard", to: "weather_dashboard#index"
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/map', to: "conditions#map"
  get 'bike-shop', to: 'items#index'
  get '/:name', to: 'stations#show'
end
