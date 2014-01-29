class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if current_user #put in helper method?
      if current_user.id == @user.id #also included in helper method?
        @providers = current_user.providers 
        @posts = []
        current_user.authors.each do |author|
          author.posts.each do |post|
            post.author = author
            @posts << post
          end
        end
        @posts.sort!{|a, b| b.posted_at<=> a.posted_at}
      else
        flash[:notice] = "You are not authorized to view this page!"
        redirect_to user_path(current_user)
      end
    else #part of helper method
      flash[:notice] = "You must be signed in to view this page!"
      redirect_to root_path
    end
  end
  
end
