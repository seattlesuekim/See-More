class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if current_user
      if current_user.id == @user.id
        @providers = current_user.providers 
      else
        flash[:notice] = "You are not authorized to view this page!"
        redirect_to user_path(current_user)
      end
    else
      flash[:notice] = "You must be signed in to view this page!"
      redirect_to root_path
    end
  end
  
end
