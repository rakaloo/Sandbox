module ApplicationHelper

  def admin_user?
    current_user && current_user.role == "Admin"
  end


end
