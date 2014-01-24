module ApplicationHelper

   def create_author_hash(r)
    author = {}
    author[:username] = r.screen_name
    author[:type] = "TwitterAuthor"
    author[:uid] = r.id
    author[:avatar] = r.profile_image_url
    author
  end
end
