Rails.application.routes.draw do
  root "welcome#index"

  resources :conditions, only: [:index, :show]
  resources :users, only: [:new, :create]

  get "/dashboard", to: "users#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :trips do
    collection do
      get :more
    end
  end

  resources :trips

  resources :stations, only: [:index, :show]
end
