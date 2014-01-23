SeePeeps::Application.routes.draw do

  root to: "welcome#home" 
  get "welcome/signin", as: :sign_in
  get "/signout", to: "sessions#destroy", as: :sign_out
  
  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"

  post '/search', to: 'posts#search', as: :search

  resources :posts
  resources :users
 end
