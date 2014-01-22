class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    raise 
  new

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice:"You have logged out!"
  end


end
