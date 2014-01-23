SeePeeps::Application.routes.draw do

  root to: "users#show" 

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"
  get "/signout", to: "sessions#destroy", as: :sign_out
<<<<<<< HEAD
  # get '/users/:id', to: "users#show"
=======
  post '/search', to: 'posts#search', as: :search
>>>>>>> master

  resources :posts
  resources :users
 end
