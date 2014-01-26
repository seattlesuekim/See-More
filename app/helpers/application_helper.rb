module ApplicationHelper

   def create_author_hash(r)
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

end
