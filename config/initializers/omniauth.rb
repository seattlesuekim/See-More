# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, ENV["TWITTER_CLIENT_ID"], ENV["TWITTER_CLIENT_SECRET"]
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CLIENT_ID'], ENV['TWITTER_CLIENT_SECRET']
  provider :tumblr, ENV['TUMBLR_CLIENT_ID'], ENV['TUMBLR_CLIENT_SECRET']
  provider :instagram, ENV['INSTAGRAM_CLIENT_ID'], ENV['INSTAGRAM_CLIENT_SECRET']  
end