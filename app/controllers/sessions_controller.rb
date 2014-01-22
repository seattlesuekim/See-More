class SessionsController < ApplicationController

  def create
    
  new

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice:"You have logged out!"
  end


end
