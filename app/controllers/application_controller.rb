class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  helper_method :current_user


  def current_user
    super || guest_user
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "Congratulations, you're signed up!"
    '/chess'
  end

  def guest_user
    if guest_user?
      User.find(session[:guest_user_id])
    else
      false
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
end