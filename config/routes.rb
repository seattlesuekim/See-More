SeePeeps::Application.routes.draw do

  # resources :users

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"

  get "/signout", to: "sessions#destroy", as: :sign_out
  # get '/users/:id', to: "users#show"

  root to: "users#show" 
  
 end
