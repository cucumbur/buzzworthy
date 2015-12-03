class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def reset_all_users_motivation
  	User.all.each { |user| user.reset_motivation }
  	flash[:notice] = "You refreshed all players' motivation."
  	redirect_to admin_path
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
