module ApplicationHelper


  def create_twitter_author_hash(r)
    author = {}
    author[:username] = r.screen_name
    author[:type] = "TwitterAuthor"
    author[:uid] = r.id
    author[:avatar] = r.profile_image_url
    author
  end

  def create_tum_author_hash(tumblr_results)
    author = {}
    author[:username] = tumblr_results["blog"]["name"]
    author[:type] = "TumblrAuthor"
    author[:uid] = tumblr_results["blog"]["name"]
    author[:avatar] = "http://api.tumblr.com/v2/blog/#{tumblr_results["blog"]["name"]}.tumblr.com/avatar/512"
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
