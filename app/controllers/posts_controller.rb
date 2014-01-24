class PostsController < ApplicationController
  before_action :set_twitter_client, :set_tumblr_client

  def create
  end

  def index
  end

  def search
    @search = @client.user_search(params[:search], count: 50).collect 
    flash[:notice] = "Search results for \"#{params[:search]}\""
    render :index
  end

  def searchpage
  end

  def search_tum
    @tumblr_results = get_tumblr_results
    if @tumblr_results == {"status"=>404, "msg"=>"Not Found"}
      redirect_to "/", notice: "No users match your search." 
    else
      flash[:notice] = "Search results for \"#{params[:search_tum]}\""
    end
  end

  private
  def set_tweets
    # @tweets = client.user_timeline(<author>, :count =>10).collect  
  end

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret = ENV["TWITTER_CLIENT_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def set_tumblr_client
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_CLIENT_ID"]
      config.consumer_secret = ENV["TUMBLR_CLIENT_SECRET"]
      config.oauth_token = ENV["TUMBLR_ACCESS_TOKEN"]
      config.oauth_token_secret = ENV["TUMBLR_ACCESS_TOKEN_SECRET"]
    end
  end

  def get_tumblr_results
    client = Tumblr::Client.new
    client.posts(params[:search_tum])
  end
    
end
