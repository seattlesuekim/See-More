class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def current_user
  #   if session[:user_id]
  #     @current_user = User.find(session[:user_id])
  #   elsif cookies.permanent[:user_id] && User.find_by(cookie_id: cookies.permanent[:user_id])
  #     @current_user = User.find_by(cookie_id: cookies.permanent[:user_id])
  #     session[:user_id] = @current_user.id
  #   else
  #     cookies.permanent[:user_id] = (Time.now.nsec + rand(10000)).to_s
  #     user = User.new(cookie_id: cookies.permanent[:user_id])
  #     if user.save
  #       @current_user = user
  #       session[:user_id] = @current_user.id
  #     else
  #       flash[:notice] = "there was a problem saving this user"
  #     end
  #   end
  #   @current_user
  # end

  helper_method :current_user
  
end
