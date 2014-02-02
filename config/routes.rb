SeePeeps::Application.routes.draw do

  root to: "welcome#home"
  # Authentication routes
  get "/auth/:provider/callback",   to: "sessions#create"
  post "/auth/:provider/callback",  to: "sessions#create"
  get "/signout",                   to: "sessions#destroy", as: :sign_out

  # Search routes
  post'/search/:service',          to: 'posts#search',           as: :search
  post '/rss',                     to: 'posts#fetch_rss',        as: :rss
  
  delete 'unsubscribe/:id',        to: 'authors#unsubscribe',    as: :unsubscribe
  post '/tweet',                   to: 'posts#tweet',            as: :tweet
  post '/favorite',                to: 'posts#favorite',         as: :favorite
  post '/retweet',                 to: 'posts#retweet',          as: :retweet
  post '/tumblr',                  to: 'posts#post_to_tumblr',   as: :tumblr


  resources :posts
  resources :users
  resources :authors
  resources :user_authors
 end
