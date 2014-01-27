class Post < ActiveRecord::Base
  belongs_to :author

  attr_accessor :feed, :post

  # RSS feed from other blogs
  def self.from_rss(url)
    @feed = Feedzirra::Feed.fetch_and_parse(url,
                                            :on_success => lambda {|url, feed| puts feed.title },
                                            :on_failure => lambda {|curl, error| puts 'Invalid feed URL. Please try again.' })
    entry = @feed.entries.first
    @post = Post.new do |p|
      p.author_id = entry.author
      p.body = entry.content
      p.title = entry.title
      #p.posted_at = entry.published
      # p.created_at = Automatically gets set to the current date and time when the record is first created.
    end
    @post.save
    @post
  end

  def self.update_rss
    Feedzirra::Feed.update(@feed)
  end

end