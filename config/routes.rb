SeePeeps::Application.routes.draw do

  root to: "welcome#home"

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"
  get "/signout", to: "sessions#destroy", as: :sign_out

  post '/twitter_search', to: 'posts#twitter_search', as: :twitter_search
  post '/search_tum', to: 'posts#search_tum', as: :search_tum
  post '/rss',        to: 'posts#get_rss',    as: :rss

  delete 'unsubscribe/:id', to: 'authors#unsubscribe', as: :unsubscribe
  post '/tweet', to: 'posts#tweet', as: :tweet
  post '/favorite', to: 'posts#favorite', as: :favorite
  post '/retweet', to: 'posts#retweet', as: :retweet
  
  post '/tumblr', to: 'posts#post_to_tumblr', as: :tumblr

  resources :posts
  resources :users
  resources :authors
  resources :user_authors
 end
