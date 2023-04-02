Rails.application.routes.draw do
  
  # USERS
  resources :users  #, only: [:index, :update, :destroy]

  # POST /signup
  post "/signup", to: "users#create"

  # Stay logged in
  get "/me", to: "users#show"

  # Sessions
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # RECIPES
  resources :recipes

  # REVIEWS
  resources :reviews

  # TAGS
  resources :tags


end
