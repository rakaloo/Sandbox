class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def unauthorized
    render file: "/public/404.html"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
  end

  def check_if_banned
    redirect_to unauthorized_path if banned?
  end

  def banned?
    current_user && current_user.role == "Banned"
  end

  def admin_user?
    current_user && current_user.role == "Admin"
  end

end
