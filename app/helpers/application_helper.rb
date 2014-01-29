module ApplicationHelper

  def create_twitter_author_hash(result)
    author = {}
    author[:username] = result.screen_name
    author[:type] = "TwitterAuthor"
    author[:uid] = result.id
    author[:avatar] = result.profile_image_url
    author
  end

  def create_tum_author_hash(result)
    author = {}
    author[:username] = result["blog"]["name"]
    author[:type] = "TumblrAuthor"
    author[:uid] = result["blog"]["name"]
    author[:avatar] = "http://api.tumblr.com/v2/blog/#{result["blog"]["name"]}.tumblr.com/avatar/512"
    author
  end

  def display_content_with_links(text)
     text.gsub(/(http:\/\/[a-zA-Z0-9\/\.\+\-_:?&=]+)/) {|a| "<a href=\"#{a}\" target='_blank'>#{a}</a>"}  
  end

  def has_twitter_provider
    types = current_user.providers.map {|p| p.name}
    types.include? "twitter"
  end

end
