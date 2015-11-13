class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def admin
  	if current_user and current_user.admin?
  		#blah
  	else
  		flash[:danger] = "Naughty, naughty..."
  		redirect_to root_url
  	end
  	
  end
end
