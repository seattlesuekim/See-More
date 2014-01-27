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

  def self.add_posts(keyword, uid)
    response = TumblrAuthor.client.posts(keyword)
    posts = response["posts"]
    posts.each do |post|
      if post["type"].eql?("link")
        p = Post.new(author_id: uid, body: post["url"], title: post["title"], posted_at: post["date"])
      elsif post["type"].eql?("video")
        p = Post.new(author_id: uid, body: post["permalink_url"], title: post["title"], posted_at: post["date"])
      elsif post["type"].eql?("photo")
        p = Post.new(author_id: uid, body: post["short_url"], title: post["title"], posted_at: post["date"])
      elsif post["type"].eql?("answer")
        p = Post.new(author_id: uid, body: post["short_url"], title: post["title"], posted_at: post["date"])
      elsif post["type"].eql?("text")
        p = Post.new(author_id: uid, body: post["body"], title: post["title"], posted_at: post["date"])
      elsif post["type"].eql?("chat")
        p = Post.new(author_id: uid, body: post["body"],title: post["title"], posted_at: post["date"])
      elsif post["type"].eql?("quote")
        p = Post.new(author_id: uid, body: post["text"], title: post["title"], posted_at: post["date"])
      else post["type"].eql?("audio")
        p = Post.new(author_id: uid, body: post["source_url"], title: post["title"], posted_at: post["date"])
      end

      p.save!
    end

  end


end
