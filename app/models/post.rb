class Post < ActiveRecord::Base
  belongs_to :author
  attr_accessor :feed

  def self.create_tumblr_post(post)
    author = Author.find_by(uid: post['blog_name'])
    case post['type']
      when 'video'
        author.posts << self.create(body: post["player"].first["embed_code"], posted_at: post["date"])
      when 'text'
        author.posts << self.create(body: post["body"], posted_at: post["date"])
      when 'quote'
        author.posts << self.create(body: "#{post["text"]} #{post["source"]}", posted_at: post["date"])
      when 'chat'
        chat = post['body'].gsub(/\r\n/, '<br>')
        author.posts << self.create(body: chat, posted_at: post["date"])
      when 'answer'
        author.posts << self.create(body: post["body"], posted_at: post["date"])
      when 'photo'
        photoset = post['photos'].map {|photo| "<img src= '#{photo['original_size']['url']}', width= '450'>"}.join("")
        author.posts << self.create(body: photoset, posted_at: post["date"])
      when 'audio'
        author.posts << self.create(body: post["player"], posted_at: post["date"])
    end
  end

 #   if post["type"].eql?("link")
    #     p = Post.find_or_create_by_body(author_id: uid, body: "#{post["url"]}#{post["description"]}", title: post["title"], posted_at: post["date"])

    #   # elsif post["type"].eql?("video")
    #   #   next
    #     # p = Post.find_or_create_by_body(author_id: uid, body: post["player"].first["embed_code"],  title: post["source_title"], posted_at: post["date"])
    #     # p = Post.find_or_create_by_body(author_id: uid, body: post["short_url"],  title: post["source_title"], posted_at: post["date"])
    
    #   elsif post["type"].eql?("photo")
        
    #     p = Post.find_or_create_by_body(author_id: uid, body: "#{post["caption"]}#{post["photos"].last}", title: post["title"], posted_at: post["date"])
      
    #   elsif post["type"].eql?("answer")
    #     p = Post.find_or_create_by_body(author_id: uid, body: post["answer"], title: post["title"], posted_at: post["date"])
      
    #   elsif post["type"].eql?("text")
    #     p = Post.find_or_create_by_body(  
      
    #   elsif post["type"].eql?("chat")
    #     p = Post.find_or_create_by_body(author_id: uid, title: post["title"], body: post["body"],  posted_at: post["date"])
      
    #   elsif post["type"].eql?("quote")
    #     p = Post.find_or_create_by_body(author_id: uid, body: "#{post["text"]}#{post["source"]}", title: post["title"], posted_at: post["date"])
      
    #   else post["type"].eql?("audio")
    #     p = Post.find_or_create_by_body(author_id: uid, body: post["player"], title: post["title"], posted_at: post["date"])
    #   end

    #   p.save!
    # end
end