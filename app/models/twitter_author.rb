class TwitterAuthor < Author

  def self.client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret = ENV["TWITTER_CLIENT_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  # I don't know how to make Rails do this one yet:

  # def find_posts(author)
  #   TwitterAuthor.client.user_timeline(author[:username]).collect.each do |tweet|
  #     @post = Post.new(author_id: author[:id], body: tweet.text, posted_at: tweet.created_at)
  #     @post.save
  #   end
  # end

end

 