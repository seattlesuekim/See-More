class AuthorsController < ApplicationController
  before_action :set_author, only: [:delete]

  def create
    if Author.find_by_uid(params[:author][:uid])
      @author = Author.find_by_uid(params[:author][:uid])
      create_user_author
    else
      @author = Author.new(author_params)
      if @author.save
        create_user_author
      else
        redirect_to :back, notice: "Something went wrong"
      end
    end 
  end

  def create_user_author
    @user_author = UserAuthor.find_by(author_id: @author.id, user_id: session[:user_id])

    if @user_author 
      redirect_to posts_path, notice: "You are already subscribed to #{@author.username}!" and return
    else
      @user_author = UserAuthor.new(author_id: @author.id, user_id: session[:user_id])
    end

    if @user_author.save
      redirect_to posts_path
    else
      render :search_results, notice: "Something went wrong"
    end
  end

  def delete
    
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:username, :provider, :uid, :avatar)
  end

end
#{}