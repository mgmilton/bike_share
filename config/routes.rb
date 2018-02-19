Rails.application.routes.draw do
  root "welcome#index"

  resources :conditions, only: [:index, :show]

  resources :users, only: [:new, :create]
  get "/dashboard", to: "users#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/trips-dashboard", to: "trips_dashboard#index"
  get "/weather-dashboard", to: "weather_dashboard#index"

  resources :trips, only: [:index, :show]

  resources :stations, only: [:index, :show], param: :name
  get '/stations-dashboard', to: 'stations#dashboard'
end
