class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    auth_hash = request.env['omniauth.auth']
    ## OLD VERSION
    # @provider = Provider.find_or_create_from_omniauth(auth_hash)
    # session[:user_id] = @provider.user_id
    # redirect_to user_path(session[:user_id]), notice: "You have been successfully signed in!"
    @provider = Provider.find_by(uid: auth_hash[:uid])
    if @provider
      session[:user_id] = @provider.user_id
      redirect_to user_path(session[:user_id]), notice: "You have been successfully signed in!"
    elsif current_user
      #find or create - right now bug with linking accounts if provider already exists
      provider = Provider.create_from_omniauth(auth_hash)
      current_user.providers << provider
      redirect_to user_path(session[:user_id]), notice: "Account added!"
    else #meant to create new user/provider. With cookie version of current_user, this condition never gets hit?
      user = User.create_from_omniauth(auth_hash)
      session[:user_id] = user.id
      provider = Provider.create_from_omniauth(auth_hash)
      user.providers << provider
      redirect_to user_path(session[:user_id]), notice: "Signed up!"
    end
    #right now, allows you to link more than one of each type of provider -- ok bc of oauth? (would need to know password and username)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice:"You have been successfully signed out!"
  end

end
