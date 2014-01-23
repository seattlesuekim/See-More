class PostsController < ApplicationController
  before_action :set_twitter_client

  def create
  end

  def index

  end

  private
  def set_tweets
    # @tweets = client.user_timeline(<author>, :count =>10).collect  
  end

  def set_twits_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret = ENV["TWITTER_CLIENT_SECRET"]
    end
  end
end
