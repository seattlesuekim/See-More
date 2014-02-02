class UsersController < ApplicationController
  before_action :home_feed
  before_action :update_feeds

  def show
    @user = User.find(params[:id])
    if current_user
      if current_user.id == @user.id
        @providers = current_user.providers #this is just for debug, can delete later
        # combine all the different feed arrays
        @posts = @instagram_posts + @home_feed
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
      @instagram_posts = []
    else
      authors.each do |author|
        if author.type == "InstagramAuthor"
          @instagram_posts = []
          Instagram.client.user_recent_media(author.uid).each do |photo|
            post = {}
            if photo.caption 
              caption = photo.caption.text
            else
              caption = ""
            end
            post[:author_name] = author.username
            post[:body] = "<img src= '#{photo.images.standard_resolution.url}', width='450'>"
            post[:posted_at] = Time.at(photo.created_time.to_i)
            post[:author_url] = author.avatar
            post[:author_type] = author.type
            post[:caption] = "<span class='instagram_caption'>#{caption}</span>"
            @instagram_posts << post
          end
        else #(eventually will be elsif)
          @instagram_posts = []
        end
      end
      # elsif author.type == "TumblrAuthor"
      # elsif author.type == "RssAuthor"
    end
  end

end

