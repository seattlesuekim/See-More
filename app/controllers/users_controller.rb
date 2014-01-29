class UsersController < ApplicationController
  before_action :home_feed

  def show
    @user = User.find(params[:id])
    if current_user
      if current_user.id == @user.id
        @providers = current_user.providers 
        @posts = []
        current_user.authors.each do |author|
          author.posts.each do |post|
            post.author = author
            @posts << post
          end
        end
        @posts.sort!{|a, b| b.posted_at <=> a.posted_at}
      else
        flash[:notice] = "You are not authorized to view this page!"
        redirect_to user_path(current_user)
      end
    else
      flash[:notice] = "You must be signed in to view this page!"
      redirect_to root_path
    end
  end

  def home_feed
    # types = current_user.providers.map {|p| p.name}
    # if types.include? "twitter"
      user_client = TwitterAuthor.user_client(current_user)
      @home_feed = user_client.home_timeline.take(25)
    # else
    #   nil
    # end
  end
end