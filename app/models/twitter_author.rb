class TwitterAuthor < Author


  def self.client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret = ENV["TWITTER_CLIENT_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def self.user_client(user)
   
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret = ENV["TWITTER_CLIENT_SECRET"]
      config.access_token = user.providers.find_by(name: "twitter").token
      config.access_token_secret = user.providers.find_by(name: "twitter").secret
    end
  end

  def self.find_posts(author)

    @client.user_timeline(author[:username]).collect.each do |tweet|
      @post = Post.find_or_create_by_body(author_id: author[:id], body: tweet.text, posted_at: tweet.created_at)
      @post.save
    end
  end
end