class PostsController < ApplicationController
 
  before_action :set_tumblr_client, only:[:search_tum]


  def twitter_search
    @search = TwitterAuthor.client.user_search(params[:twitter_search]).collect 
    flash[:notice] = "Search results for \"#{params[:twitter_search]}\""
    render :twitter_search_results
  end

  def search_tum
    @tumblr_results = get_tumblr_results
    if @tumblr_results == {"status"=>404, "msg"=>"Not Found"}
      redirect_to "/", notice: "No users match your search." 
    else
      flash[:notice] = "Search results for \"#{params[:search_tum]}\""
    end
  end

  def rss
    Post.get_rss
  end

  private

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
