Rails.application.routes.draw do
  root "welcome#index"

  namespace :admin do
    resources :conditions, only: [:new, :create, :edit, :update, :destroy]
    resources :stations, except: [:index, :show], param: :name
    resources :trips, only: [:new, :edit, :update, :destroy, :create]
    resources :users, only: [:show]
    resources :items, except: [:destroy], path: 'bike-shop', param: :title
  end

  resources :conditions, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :stations, only: [:index]
  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:create, :show]
  resources :carts, only: [:create, :show]
  patch "/remove_item", to: "carts#remove_item"
  resources :items, path: 'bike-shop', only: [:show, :index], param: :title

  get "/dashboard", to: "users#show"
  get "/cart", to: "carts#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/trips-dashboard", to: "trips_dashboard#index"
  get "/weather-dashboard", to: "weather_dashboard#index"
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/map', to: "conditions#map"
  get '/stations-dashboard', to: 'stations#dashboard'

  scope :admin, as: :admin do
    get '/dashboard', to: 'users#show'
  end

  get '/:name', to: 'stations#show'
end
