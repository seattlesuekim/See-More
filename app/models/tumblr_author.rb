class TumblrAuthor < Author

  def self.client
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret = ENV["TUMBLR_CLIENT_SECRET"]
      config.oauth_token = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end
    Tumblr::Client.new
  end

  def self.add_posts(keyword) #shouldn't this actually be an instance method?
    response = TumblrAuthor.client.posts(keyword)
    posts = response["posts"]
    @posts = posts.map do |post|
      Post.create_tumblr_post(post)
    end
  end

end
