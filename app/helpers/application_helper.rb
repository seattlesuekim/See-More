module ApplicationHelper

  def create_twitter_author_hash(result)
    author = {}
    author[:username]  = result.screen_name
    author[:type]      = "TwitterAuthor"
    author[:uid]       = result.id
    author[:avatar]    = result.profile_image_url
    author
  end

  def create_tum_author_hash(result)
    author = {}
    author[:username]   = result["blog"]["name"]
    author[:type]       = "TumblrAuthor"
    author[:uid]        = result["blog"]["name"]
    author[:avatar]     = "http://api.tumblr.com/v2/blog/#{result["blog"]["name"]}.tumblr.com/avatar/512"
    author
  end

  def create_instagram_author(result)
    author = {}
    author[:username]  = result.username
    author[:type]      = "InstagramAuthor"
    author[:uid]       = result.id
    author[:avatar]    = result.profile_picture
    author
  end

  def render_post(post)
    if post[:author_type] == "TwitterAuthor"
      @rendered = post[:body].gsub(/(http[s]?:\/\/[a-zA-Z0-9\/\.\+\-_:?&=]+)/) {|a| "<a href=\"#{a}\" target='_blank'>#{a}</a>"}
    elsif post[:author_type] == "TumblrAuthor"
      @rendered = post[:body]
    elsif post[:author_type] =="InstagramAuthor"
      @rendered = post[:body] + "<br>" + post[:caption]
    end
    @rendered.html_safe
  end

  def has_twitter_provider
    types = current_user.providers.map {|p| p.name}
    types.include? "twitter"
  end

  def has_tumblr_provider
    types = current_user.providers.map {|p| p.name}
    types.include? "tumblr"
  end

  def img_linkify(p)
   case p[:author_type]
   when "TwitterAuthor"
    link_to image_tag("#{p[:author_url]}", class: "img-thumbnail", size: "80"), "https://twitter.com/#{p[:author_name]}", target: "_blank"
   when "TumblrAuthor"
    link_to image_tag("#{p[:author_url]}", class: "img-thumbnail", size: "80"), "http://#{p[:author_name]}.tumblr.com", target: "_blank"
   else
    image_tag("#{p[:author_url]}", class:  "img-thumbnail", size: "80")
   end
  end

  def txt_linkify(p)
   case p[:author_type]
   when "TwitterAuthor"
    link_to p[:author_name], "https://twitter.com/#{p[:author_name]}", target: "_blank"
   when "TumblrAuthor"
    link_to p[:author_name], "http://#{p[:author_name]}.tumblr.com", target: "_blank"
   else
    p[:author_name]
   end
  end

  def auth_img_linkify(a)
   case a.type
   when "TwitterAuthor"
    link_to image_tag("#{a.avatar}", class: "img-thumbnail", size: "80"), "https://twitter.com/#{a.username}", target: "_blank"
   when "TumblrAuthor"
    link_to image_tag("#{a.avatar}", class: "img-thumbnail", size: "80"), "http://#{a.username}.tumblr.com", target: "_blank"
   else
    image_tag("#{a.avatar}", class: "img-thumbnail", size: "80")
   end
  end

  def auth_txt_linkify(a)
   case a.type
   when "TwitterAuthor"
    link_to a.username, "https://twitter.com/#{a.username}", target: "_blank"
   when "TumblrAuthor"
    link_to a.username, "http://#{a.username}.tumblr.com", target: "_blank"
   else
    a.username
   end
  end

end
