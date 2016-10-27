class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  ### user before filters on in your methods to call to make sure a user is logged in.  Two examples below
  # before_filter :authenticate_user!, except: [:index]
  # before_filter :user_signed_in?

  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin_user?
    current_user && current_user.role == "Admin"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
  end
end
