class PostsController < ApplicationController
  before_action :set_twitter_client, only:[:tweet, :favorite, :retweet]
  before_action :set_tumblr_client, only:[:post_to_tumblr]

  def search
    if params[:service] == "instagram"
      @results = InstagramAuthor.client.user_search(params[:instagram])
      render :instagram_results #all the renders should be refactored to one search page
    elsif params[:service] == "tumblr"
      @tumblr_results = TumblrAuthor.client.posts(params[:search_tum])
      if @tumblr_results == {"status"=>404, "msg"=>"Not Found"}
        redirect_to user_path(current_user), notice: "No users match your search."
      else
        flash[:notice] = "Search results for \"#{params[:search_tum]}\""
        render :search_tum # see above
      end
    elsif params[:service] == "twitter"
      @search = TwitterAuthor.client.user_search(params[:twitter_search]).collect
      flash[:notice] = "Search results for \"#{params[:twitter_search]}\""
      render :twitter_search #see above
    elsif params[:service] == "github"
      @search = []
      @res = GithubAuthor.client.search_users(params[:github_search])
      @res.items.each do |item|
        user = item.rels[:self].get.data
        httparty_response = HTTParty.get("https://api.github.com/users/#{user.login}", :headers => {"User-Agent" => "rss-peep"})
        user = {
          avatar: httparty_response["avatar_url"],
          id: user.id,
          username: user.login,
          link: httparty_response["html_url"]
        }
        @search << user
      end
      @search
      flash[:notice] = "Search results for \"#{params[:github_search]}\""
      render :github_search_results
    end
  end

  def fetch_rss
    url = params[:get_rss]
    feed = Feedzirra::Feed.fetch_and_parse(url)
    feed = nil if feed.is_a?(Fixnum)

    if feed
      # get an icon from Feedzirra somehow?
      @author = current_user.authors.create(username: url.match(/http:\/\/www.\w+\.\w+/).to_s, uid: url, type: "RssAuthor", avatar: "")
      feed.entries.each do |entry|
        @author.posts.create(
          author_id: (Author.find_by username: @author.username).id,
          body: entry.content,
          title: entry.title,
          posted_at: entry.published)
          # p.created_at automatically gets set to the current date and time when the record is first created.
        end
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

  def post_to_tumblr
    blogname = current_user.providers.where(name:"tumblr").first.username
    @tumblr_client.text("#{blogname}.tumblr.com", {body: params[:tumblr]})
    redirect_to user_path(current_user)
  end

  private

  def set_twitter_client
    @user_client = TwitterAuthor.user_client(current_user)
  end

  def set_tumblr_client
    @tumblr_client = TumblrAuthor.user_client(current_user)
  end

end
