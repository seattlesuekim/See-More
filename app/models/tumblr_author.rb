class TumblrAuthor < Author

  def self.client
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret = ENV["TUMBLR_CLIENT_SECRET"]
      #this should be the user's (i.e. provider's) secret token eventually
      config.oauth_token = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end
    Tumblr::Client.new
  end

  def self.add_posts(keyword)
    response = TumblrAuthor.client.posts(keyword)
    posts = response["posts"]
    # raise
    @posts = posts.map do |post|
      Post.create_tumblr_post(post)
    end
  end

end
