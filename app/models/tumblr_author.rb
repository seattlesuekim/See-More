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

  def self.user_client(user)
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret = ENV["TUMBLR_CLIENT_SECRET"]
      config.oauth_token = user.providers.find_by(name: "tumblr").token
      config.oauth_token_secret = user.providers.find_by(name: "tumblr").secret
    end
    Tumblr::Client.new
  end

# change this to fetch post and put it in a before action
# keyword must match the username, which is saved
  # def self.add_posts(keyword)
  #   response = TumblrAuthor.client.posts(keyword)
  #   posts = response["posts"]
  #   @posts = posts.map do |post|
  #     Post.create_tumblr_post(post)
  #   end
  # end

end
