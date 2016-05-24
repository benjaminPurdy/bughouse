class UsersController < ApplicationController
  protect_from_forgery except: :create_guest

  def create_guest
    user = User.new { |user| user.guest = true }
    user.email = "guest_#{Time.now.to_i}#{rand(99)}@example.com"
    user.save(:validate => false)
    user
    session[:guest_user_id] = user.id

    redirect_to '/chess'
  end
end
