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
end