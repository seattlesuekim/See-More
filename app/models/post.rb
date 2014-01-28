class Post < ActiveRecord::Base
  belongs_to :author
  attr_accessor :feed

  # RSS feed from other blogs
  # Sometimes the Author isn't available; it's nil. What to do?
  def self.from_rss(url)
    @feed = Feedzirra::Feed.fetch_and_parse(url)
    if not @feed.is_a?(Fixnum) && @feed != nil
      entry = @feed.entries.first
      author = Author.new
      author.username = entry.author || @feed.title
      @post = Post.new do |p|
        p.author_id = (Author.find_by username: author.username).id
        p.body = entry.content
        p.title = entry.title
        p.posted_at = entry.published
        # p.created_at = Automatically gets set to the current date and time when the record is first created.
      end
      raise()
      @post.save
      @post
    end
  end

  def self.update_rss
    Feedzirra::Feed.update(@feed)
  end

end