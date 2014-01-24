module ApplicationHelper

   def create_author_hash(r)
    author = {}
    author[:username] = r.screen_name
    author[:provider] = "twitter"
    author[:uid] = r.id
    author[:avatar] = r.profile_image_url
    author
  end
end
