Rails.application.routes.draw do
  root "welcome#index"

  resources :conditions, only: [:index, :show]

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

  resources :trips, only: [:index, :show]

  resources :stations, only: [:index]
  get '/:name', to: 'stations#show'
<<<<<<< HEAD

  get 'bike-shop/new', to: 'items#new'
=======
>>>>>>> change stations show route to just name
end
