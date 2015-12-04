class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end
  helper_method :forem_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def reset_all_users_motivation
  	User.all.each { |user| user.reset_motivation }
  	flash[:notice] = "You refreshed all players' motivation."
  	redirect_to admin_path
  end
  
  def toggle_chat
  	if !session[:chat_enable].nil?
  		session[:chat_enable] = !(session[:chat_enable])
  	else
  		session[:chat_enable] = true
  	end
  	redirect_to root_path
  end
 
  
  private
  
  	# Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        # store_location
        flash[:danger] = "Naughty, naughty..."
        redirect_to login_url
      end
    end
    
    # Confirms a logged-in user.
    def admin_user
      unless logged_in?
        # store_location
        flash[:danger] = "Naughty, naughty..."
        redirect_to login_url
      end
      unless current_user.admin?
        # store_location
        flash[:danger] = "Naughty, naughty..."
        redirect_to root_path
      end
    end
  
end
