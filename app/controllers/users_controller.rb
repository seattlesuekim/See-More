class UsersController < ApplicationController

  def show
    @posts = []
    current_user.authors.each do |author|
      author.posts.each do |post|
        post.author = author
        @posts << post
      end
    end
    @posts.sort!{|a, b| b.posted_at<=> a.posted_at}
  end
  
end
