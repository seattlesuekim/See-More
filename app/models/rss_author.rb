class RssAuthor < Author

  # RSS feed from other blogs
  def self.from_rss(url)
    @feed = Feedzirra::Feed.fetch_and_parse(url)
    if not @feed.is_a?(Fixnum) && @feed != nil
      author = RssAuthor.create(username: url)
      @feed.entries.each do |entry|
        post = Post.new do |p|
          p.author_id = (Author.find_by username: author.username).id
          p.body = entry.content
          p.title = entry.title
          p.posted_at = entry.published
          # p.created_at = Automatically gets set to the current date and time when the record is first created.
        end
        post.save
      end
    end
  end

  def self.update_rss
    Feedzirra::Feed.update(@feed)
  end

end