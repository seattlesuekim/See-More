class PostsController < ApplicationController
  before_action :set_twitter_client, only:[:tweet, :favorite, :retweet]

  def twitter_search
    @search = TwitterAuthor.client.user_search(params[:twitter_search]).collect
    flash[:notice] = "Search results for \"#{params[:twitter_search]}\""
    render :twitter_search_results
  end

  def search_tum
    @tumblr_results = get_tumblr_results
    if @tumblr_results == {"status"=>404, "msg"=>"Not Found"}
      redirect_to user_path(current_user), notice: "No users match your search."
    else
      flash[:notice] = "Search results for \"#{params[:search_tum]}\""
    end
  end

  def get_rss
    @rss = RssAuthor.from_rss(params[:get_rss])
    if @rss
      flash[:notice] = "Feed successfully added!"
      redirect_to user_path(current_user)
    else
      flash[:notice] = "There was a problem saving your feed!"
      redirect_to user_path(current_user)
    end
  end

  def tweet
    @user_client.update(params[:tweet])
    redirect_to :back, notice: "Your tweet has been successfully posted!"
  end

  def favorite
    @user_client.favorite(params[:tweet][:pid])
    redirect_to :back, notice: "You have successfully favorited this tweet!"
  end

  def retweet
    @user_client.retweet(params[:tweet][:pid])
    redirect_to :back, notice: "You have successfully retweeted this tweet!"
  end

  private

  def get_tumblr_results
    TumblrAuthor.client.posts(params[:search_tum])
  end

  def set_twitter_client
    @user_client = TwitterAuthor.user_client(current_user)
  end

end
