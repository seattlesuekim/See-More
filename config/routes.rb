SeePeeps::Application.routes.draw do

  root to: "users#show" 

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"
  get "/signout", to: "sessions#destroy", as: :sign_out
  post '/search', to: 'posts#search', as: :search

  resources :posts
  resources :users
  resources :authors
 end
