class UsersController < ApplicationController
  # before_action :home_feed
  before_action :update_feeds

  def show
    @user = User.find(params[:id])
    if current_user
      if current_user.id == @user.id
        @providers = current_user.providers #this is just for debug, can delete later
        # combine all the different feed arrays
        @posts = @updates #+ @home_feed
        # else
        #   @posts = []
        # end
        # current_user.posts.each do |post|
        #   p = {}
        #   p[:author_name] = post.author.username
        #   p[:body] = post.body
        #   p[:posted_at] = post.posted_at
        #   p[:author_url] = post.author.avatar.gsub('normal', 'reasonably_small')
        #   p[:author_type] = post.author.type
        #   p[:pid] = post.pid
        #   p[:caption] = post.title
        #   @posts << p
        # end
        @posts = @posts.uniq {|p| p[:body]}
        @posts.sort!{|a, b| b[:posted_at]<=> a[:posted_at]}
        @posts = @posts.paginate(:page => params[:page], :per_page => 25)
      else
        flash[:notice] = "You are not authorized to view this page!"
        redirect_to user_path(current_user)
      end
    else #part of helper method
      flash[:notice] = "You must be signed in to view this page!"
      redirect_to root_path
    end
  end

  private

  def home_feed
    if current_user
      types = current_user.providers.map {|p| p.name}
      if types.include? "twitter"
        user_client = TwitterAuthor.user_client(current_user)
        @home_feed = []
        user_client.home_timeline.take(25).each do |t|
          p = {}
          p[:author_name] = t.user.screen_name
          p[:body] = t.text
          p[:posted_at] = t.created_at
          p[:author_url] = t.user.profile_image_url.to_s.gsub('normal', 'reasonably_small')
          p[:author_type] = "TwitterAuthor"
          p[:pid] = t.id
          @home_feed << p
        end
      else 
        @home_feed = []
      end
    else 
      flash[:notice] = "You must be signed in to view this page!"
    end
  end

  def update_feeds 
    authors = current_user.authors
    if authors.empty?
      @updates = []
    else
      @updates = []
      authors.each do |author|
        if author.type == "InstagramAuthor"
          Instagram.client.user_recent_media(author.uid).each do |photo|
            post = {author_name:author.username, author_url: author.avatar, author_type: author.type}
            if photo.caption 
              caption = photo.caption.text
            else
              caption = ""
            end
            post[:body] = "<img src= '#{photo.images.standard_resolution.url}', width='450'>"
            post[:posted_at] = Time.at(photo.created_time.to_i)
            post[:caption] = "<span class='instagram_caption'>#{caption}</span>"
            @updates << post
          end
        elsif author.type == "TwitterAuthor" #(eventually will be elsif)
          TwitterAuthor.client.user_timeline(author.username).collect.each do |tweet|
            post = {author_name:author.username, author_url: author.avatar, author_type: author.type}
            post[:body] = tweet.text 
            post[:posted_at] = tweet.created_at
            post[:pid] = tweet.id
            @updates << post
          end
        elsif author.type == "TumblrAuthor"
          posts = TumblrAuthor.client.posts(author.username)["posts"]
          posts.each do |t|
            @updates << tumblr_hash(t,author)        
          end
        else 
          @updates = []
        end
      end
    end
  end

  private

  def tumblr_hash(t, author)
    post = {  author_name:author.username, 
              author_url: author.avatar, 
              author_type: author.type,
              posted_at: t['date'].to_time
            }
    if t['type']    == 'text'
      post[:body]   = t["body"]
    elsif t['type'] == 'video'
      post[:body]   = t["player"].first["embed_code"]
    elsif t['type'] == 'audio'
      post[:body] = t["player"]
    elsif t['type'] == 'chat'
      chat = t['body'].gsub(/\r\n/, '<br>')
      post[:body] = chat
    elsif t['type'] == 'quote'
      post[:body] = '<h4>' + t["text"] + '</h4>' + '<br>' + '<em>' + '--' + t["source"] + '<em>'
    elsif t['type'] == 'photo'
      photoset = t['photos'].map {|photo| "<img src= '#{photo['original_size']['url']}', width= '450'>"}.join("")
      post[:body] = photoset
    elsif t['type'] == 'link'
      post[:body] = '<a href="' + t['url'] + '">' + t['title'] + '</a>'
    elsif t['type'] == 'answer'
      post[:body] = t['body']
    end
    post

  end

end

