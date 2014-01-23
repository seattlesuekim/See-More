class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash['uid']
      # @user = User.find_or_create_from_omniauth(auth_hash)
      @provider = Provider.find_or_create_from_omniauth(auth_hash)
      # @user = @provider.user
      if @provider
        if @provider.user_id
          session[:user_id] = @provider.user_id
          redirect_to root_path, notice: "You have successfully logged in!"
        else
          #figure out how to attach user to provider
          redirect_to root_path, notice: "Failed to save the user"
        end
      else
        #something for if the provider doesn't save
      end
    else
      redirect_to root_path, notice: "Failed to authenticate"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice:"You have logged out!"
  end


end
