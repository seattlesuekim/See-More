class RssAuthor < Author

  def self.update_rss
    Feedzirra::Feed.update(@feed)
  end

end

