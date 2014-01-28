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
        p = Post.find_or_create_by_body(author_id: uid, body: "#{post["url"]}#{post["description"]}", title: post["title"], posted_at: post["date"])

      elsif post["type"].eql?("video")
        p = Post.find_or_create_by_body(author_id: uid, body: post["player"].first["embed_code"],  title: post["source_title"], posted_at: post["date"])
      
      elsif post["type"].eql?("photo")
        p = Post.find_or_create_by_body(author_id: uid, body: "#{post["caption"]}#{post["photos"].last}", title: post["title"], posted_at: post["date"])
      
      elsif post["type"].eql?("answer")
        p = Post.find_or_create_by_body(author_id: uid, body: post["answer"], title: post["title"], posted_at: post["date"])
      
      elsif post["type"].eql?("text")
        p = Post.find_or_create_by_body(author_id: uid, body: post["body"], title: post["title"], posted_at: post["date"])
      
      elsif post["type"].eql?("chat")
        p = Post.find_or_create_by_body(author_id: uid, title: post["title"], body: post["body"],  posted_at: post["date"])
      
      elsif post["type"].eql?("quote")
        p = Post.find_or_create_by_body(author_id: uid, body: "#{post["text"]}#{post["source"]}", title: post["title"], posted_at: post["date"])
      
      else post["type"].eql?("audio")
        p = Post.find_or_create_by_body(author_id: uid, body: post["player"], title: post["title"], posted_at: post["date"])
      end

      p.save!
    end

  end


end
