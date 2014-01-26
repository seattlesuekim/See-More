class Post < ActiveRecord::Base
  belongs_to :author

  # RSS feed from other blogs
  def self.get_rss
    feed = Feedzirra::Feed.fetch_and_parse(params[:get_rss],
    :on_success => lambda {|url, feed| puts feed.title },
    :on_failure => lambda {|curl, error| puts 'Invalid feed URL. Please try again.' })
    feed
  end

  def self.update_rss
    Feedzirra::Feed.update(feed)
  end

end
