class PostsController < ApplicationController
 
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

  def get_rss
    @rss_post = Post.from_rss(params[:get_rss])
    render :rss_results
  end

  def tweet
    user_client = TwitterAuthor.user_client(current_user)
    user_client.update(params[:tweet])
    redirect_to :back, notice: "Your tweet has been successfully posted!"
  end

  private

  def get_tumblr_results
    TumblrAuthor.client.posts(params[:search_tum])
  end
end
