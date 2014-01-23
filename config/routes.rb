SeePeeps::Application.routes.draw do

  # resources :users

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"

  get "/signout", to: "sessions#destroy", as: :sign_out

  root to: "users#show" 
  
 end
