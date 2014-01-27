class AuthorsController < ApplicationController
  before_action :set_author, only: [:delete]
  before_action :client

  def create
    @author   = Author.find_by(uid: params[:author][:uid])
    @author ||= current_user.authors.build( author_params)
    begin
      current_user.authors << @author
    rescue ActiveRecord::RecordInvalid 
      @author = nil
    end
    
    if @author
      if @author.type.eql? "TumblrAuthor"
        TumblrAuthor.add_posts(params[:author][:uid], @author.id)
      elsif @author.type.eql? "TwitterAuthor"
        TwitterAuthor.find_posts(@author)
      end
      redirect_to user_path(current_user), notice: "You are succesfully subscribed to #{@author.username}!"
    else
      redirect_to user_path(current_user), notice: "You are already subscribed to this user!"
    end
  end

  def delete
  end

  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret = ENV["TWITTER_CLIENT_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:username, :type, :uid, :avatar)
  end

end
