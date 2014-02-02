class PostsController < ApplicationController
 
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

  def fetch_rss
    url = params[:get_rss]
    feed = Feedzirra::Feed.fetch_and_parse(url)
    feed = nil if feed.is_a?(Fixnum)

    if feed
      @author = current_user.authors.create(username: url.split(/\w+:\/\//)[1], uid: url, type: "RssAuthor")
      feed.entries.each do |entry|
        post = Post.new do |p|
          p.author_id = (Author.find_by username: @author.username).id
          p.body = entry.content
          p.title = entry.title
          p.posted_at = entry.published
          # p.created_at automatically gets set to the current date and time when the record is first created.
        end
        post.save
      end
      flash[:notice] = "Feed successfully added!"
      redirect_to user_path(current_user)
    else
      flash[:notice] = "There was a problem saving your feed!"
      redirect_to user_path(current_user)
    end
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
