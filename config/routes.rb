Rails.application.routes.draw do
  root "welcome#index"

  resources :conditions, only: [:index, :show]
  resources :users, only: [:new, :create, :show]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
