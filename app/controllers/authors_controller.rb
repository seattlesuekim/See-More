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
      find_posts(@author)
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

  def find_posts(author)
    @client.user_timeline(author[:username]).collect.each do |tweet|
      @post = Post.new(author_id: author[:id], body: tweet.text, posted_at: tweet.created_at)
      @post.save
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
#{}