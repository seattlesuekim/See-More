class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    @provider = Provider.find_by(uid: auth_hash[:uid])

    
    if @provider #for existing user who is not signed in--maybe elsif
      session[:user_id] = @provider.user_id
      redirect_to user_path(session[:user_id]), notice: "You have been successfully signed in!"
    elsif current_user #for existing user who is signed in trying to link new provider
      if # find or create - right now bug with linking accounts if provider already exists
        provider = Provider.create_from_omniauth(auth_hash)
        current_user.providers << provider
        redirect_to user_path(session[:user_id]), notice: "Account added!"
      else # need to add condition if provider already belongs to another user
      end    
    else # meant to create new user/provider. With cookie version of current_user, this condition never gets hit?
      user = User.create_from_omniauth(auth_hash)
      session[:user_id] = user.id
      provider = Provider.create_from_omniauth(auth_hash)
      if provider
        user.providers << provider
        redirect_to user_path(session[:user_id]), notice: "Signed up!"
      else
        redirect_to root_path, notice: "There was a problem signing in!"
      end
    end


  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice:"You have been successfully signed out!"
  end

end
