class UsersController < ApplicationController
  before_action :home_feed

  def show
    @user = User.find(params[:id])
    if current_user
      if current_user.id == @user.id
        @providers = current_user.providers #this is just for debug
        if @home_feed
          @posts = @home_feed
        else
          @posts = []
        end
        current_user.posts.each do |post|
          p = {}
          p[:author_name] = post.author.username
          p[:body] = post.body
          p[:posted_at] = post.posted_at
          p[:author_url] = post.author.avatar.gsub('normal', 'reasonably_small') if post.author.avatar
          p[:author_type] = post.author.type
          p[:pid] = post.pid
          p[:caption] = post.title
          @posts << p
        end
        @posts = @posts.uniq {|p| p[:body]}
        @posts.sort!{|a, b| b[:posted_at]<=> a[:posted_at]}
        raise()
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
        nil
      end
    else 
      flash[:notice] = "You must be signed in to view this page!"
    end
  end
end

