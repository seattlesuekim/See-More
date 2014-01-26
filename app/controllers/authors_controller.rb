class AuthorsController < ApplicationController
  before_action :set_author, only: [:delete]

  def create

    @author   = Author.find_by(uid: params[:author][:uid])
    @author ||= current_user.authors.build( author_params)
    begin
      current_user.authors << @author
    rescue ActiveRecord::RecordInvalid 
      @author = nil
    end

    if @author
      redirect_to user_path(current_user), notice: "You are succesfully subscribed to #{@author.username}!"
    else
      redirect_to user_path(current_user), notice: "You are already subscribed to this user!"
    end
  end

  def delete
    
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:username, :type, :uid, :avatar)
  end

end
