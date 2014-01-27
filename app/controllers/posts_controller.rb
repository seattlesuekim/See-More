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

  private

  def get_tumblr_results
    TumblrAuthor.client.posts(params[:search_tum])
  end
end
