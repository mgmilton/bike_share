Rails.application.routes.draw do
  root "welcome#index"

  namespace :admin do
    resources :conditions, only: [:new, :create, :edit, :update, :destroy]
    resources :stations, except: [:index, :show], param: :name
    resources :trips, only: [:new, :edit, :update, :destroy, :create]
    resources :items, only: [:create]
    resources :users, only: [:show]
    get 'bike-shop/new', to: 'items#new'
    get 'bike-shop/edit', to: 'items#edit'
    put 'bike-shop/:title', to: 'items#update'
    delete 'bike-shop/:title', to: 'items#destroy'
  end

  resources :carts, only: [:create, :destroy, :show]
  resources :conditions, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :stations, only: [:index]
  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:create, :show]

  get "/dashboard", to: "users#show"
  get "/carts", to: "carts#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/trips-dashboard", to: "trips_dashboard#index"
  get "/weather-dashboard", to: "weather_dashboard#index"
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/map', to: "conditions#map"
  get '/stations-dashboard', to: 'stations#dashboard'
  get 'bike-shop', to: 'items#index'
  get 'bike-shop/:title', to: 'items#show'

  scope :admin, as: :admin do
    get '/dashboard', to: 'users#show'
    get '/bike-shop', to: 'items#index'
  end

  get '/:name', to: 'stations#show'
end
