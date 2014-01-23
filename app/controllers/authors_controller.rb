class AuthorsController < ApplicationController

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to root_path
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