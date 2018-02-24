Rails.application.routes.draw do
  root "welcome#index"

  resources :users, only: [:new, :create]
  get "/dashboard", to: "users#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create]

  resources :trips, only: [:index, :show]

  resources :stations, only: [:index, :show], param: :name

  resources :carts, only: [:create]

  namespace :admin do
  	resources :conditions, only: [:new, :create, :edit, :update, :destroy]
    resources :stations, except: [:index, :show], param: :name
    resources :trips, only: [:new, :edit, :update, :destroy]
    resources :items, only: [:create]
    get 'bike-shop/new', to: 'items#new'
  end

  get "/dashboard", to: "users#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/trips-dashboard", to: "trips_dashboard#index"
  get "/weather-dashboard", to: "weather_dashboard#index"
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/stations-dashboard', to: 'stations#dashboard'

  get 'bike-shop', to: 'items#index'

  resources :conditions, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :stations, only: [:index]
  get '/:name', to: 'stations#show'

  get 'bike-shop/new', to: 'items#new'
end
