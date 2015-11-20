class StaticPagesController < ApplicationController
	
	# Splash page / news page
  def home
  	redirect_to dead_path if current_user.dead?
  end

	# Help, FAQ and support page
  def help
  end

	# Admin Control Panel
  def admin
  	if current_user and current_user.admin?
  		#blah
  	else
  		flash[:danger] = "Naughty, naughty..."
  		redirect_to root_url
  	end
  	
  end
  
  # Player Death Page
  def dead
  	if !current_user
  		flash[:danger] = "Naughty, naughty..."
  		redirect_to root_url
  	elsif current_user.cur_dignity > 0
  		flash[:notice] = "C'mon, that's not funny. You're not dead."
  		redirect_to root_url
  	else # In this case, you're actually dead. Buzz resets and diginity goes back to half
  		current_user.revive
  	end
  end
  
  # Leveling up page
  # Automatically apply upgrades based on genre and let them allocate their upgrade points
  # the user must use ALL upgrade points so they cant get the genre-perks multiple times
  def levelup
  	return redirect_to root_path if !current_user
  	return redirect_to root_path, :alert => "You dont have enough buzz!" if !current_user.level_up?

  end
  
  
end
