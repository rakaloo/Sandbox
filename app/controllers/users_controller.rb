class UsersController < ApplicationController

  def index
    if current_user && current_user.role == "Admin"
      @users = User.all
    else
      render file: "/public/422.html"
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(update_user_role_params)
      redirect_to users_admin_index_path
    else
      redirect_to users_admin_index_path
    end
  end

  def destroy
    if current_user && current_user.role == "Admin"
      User.find_by(id: params[:id]).destroy
      redirect_to users_admin_index_path
    else
      render file: "/public/422.html"
    end
  end

  private

  def update_user_role_params
      params.require(:user).permit(:role)
  end
end
