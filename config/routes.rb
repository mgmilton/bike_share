Rails.application.routes.draw do
  root "welcome#index"

  resources :conditions, only: [:index, :show]

  resources :users, only: [:new, :create]

  resources :trips, only: [:index, :show]

  resources :stations, only: [:index, :show], param: :name

  resources :carts, only: [:create]

  namespace :admin do
    resources :stations, only: [:edit, :update, :destroy, :new, :create], param: :name
    resources :trips, only: [:new, :create, :edit, :update, :destroy]
    resources :conditions, only: [:new, :create, :edit, :update, :destroy]
  end

  get "/dashboard", to: "users#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/trips-dashboard", to: "trips_dashboard#index"
  get "/weather-dashboard", to: "weather_dashboard#index"
  get '/stations-dashboard', to: 'stations#dashboard'
end
