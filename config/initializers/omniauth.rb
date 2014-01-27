# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, ENV["TWITTER_CLIENT_ID"], ENV["TWITTER_CLIENT_SECRET"]
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer 
  provider :twitter, ENV['TWITTER_CLIENT_ID'], ENV['TWITTER_CLIENT_SECRET']
  provider :tumblr, ENV['TUMBLR_CLIENT_ID'], ENV['TUMBLR_CLIENT_SECRET']
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  
end