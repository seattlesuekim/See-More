class InstagramAuthor < Author

  def self.client
    Instagram.configure do |config|
      config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
      config.access_token = ENV["INSTAGRAM_SECRET_KEY"]
    end
    Instagram.client
  end

  def self.get_posts(author_uid)
    posts = Instagram.client.user_recent_media(author_uid)
    @posts = posts.map do |post|
    Post.create_instagram_post(post)
    end
  end
end
