class AuthorsController < ApplicationController
  before_action :set_author, only: [:create_user_author, :delete]

  def create
    @author = Author.new(author_params)
    if @author.save
      create_user_author
    else
      redirect_to :back, notice: "Something went wrong"
    end
    
  end

  def create_user_author
    @user_author = UserAuthor.find_by(author_id: @author.id, user_id: session[:user_id])

    if @user_author 
      redirect_to root_path, notice: "You are already subscribed to #{@author.username}" 
    else
      @user_author = UserAuthor.new(author_id: @author.id, user_id: session[:user_id])
    end

    if @user_author.save
      redirect_to posts_path
    else
      redirect_to :back, notice: "Something went wrong"
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