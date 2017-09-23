class UsersController < ActionController::Base
  protect_from_forgery except: :create_guest

  def create_guest
    user = User.as_guest
    session[:guest_user_id] = user.id
    sign_in user

    redirect_to '/chess'
  end
end
