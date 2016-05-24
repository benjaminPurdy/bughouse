class HomeController < ApplicationController

  @@refresh_online_users_timer = Time.now
  @@users_online = []

  def index
	@users_online = []
  end

  def refresh_online_users_list
  if refresh_online_users_list?
	  @@users_online = User.online
  end

  if @@users_online.nil?
    @@users_online = []
  end
  @users_online = @@users_online
	respond_to do |format|
	  format.js
	end
  end

  def refresh_online_users_list?
  	delta = Time.now - @@refresh_online_users_timer 
  	if (delta < 10)
  		false
  	else
	    @@refresh_online_users_timer = Time.now
  	  true
  	end
  end
end
