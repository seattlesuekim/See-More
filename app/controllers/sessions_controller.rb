class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    @provider = Provider.find_by(uid: auth_hash[:uid])
    
    if current_user 
      if @provider
        redirect_to user_path(session[:user_id]), notice: "This user already exists!"
      else
        provider = Provider.create_from_omniauth(auth_hash)
        current_user.providers << provider
        redirect_to user_path(session[:user_id]), notice: "Account added!"
      end    
    else # for not-logged in users
      if @provider # existing user
        session[:user_id] = @provider.user_id
        redirect_to user_path(session[:user_id]), notice: "You have been successfully signed in!"
      else #new user
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

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice:"You have been successfully signed out!"
  end

end
