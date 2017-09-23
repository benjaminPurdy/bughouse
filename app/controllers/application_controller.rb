class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #before_filter { |c| current_user.track unless current_user.nil?}
  protect_from_forgery with: :exception
  layout :layout_by_resource
  helper_method :current_user, :online_users, :current_or_guest_user

  @@refresh_online_users_timer = Time.now

  def current_or_guest_user
    if current_user
      session[:guest_user_id] = nil
      current_user
    else
      guest_user
    end
  end

  def current_user
    super
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "Congratulations, you're signed up!"
    '/chess'
  end

  def online_users
      User.online
  end

  def guest_user
    if guest_user?
      User.find(session[:guest_user_id])
    else
      nil
    end
  end

  def guest_user?
    !session[:guest_user_id].nil?
  end

  def user_signed_in?
    super || guest_user?
  end



  private
  def layout_by_resource
    if devise_controller?
      'blank'
    else
      'application'
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