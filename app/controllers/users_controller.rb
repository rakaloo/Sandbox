class UsersController < ApplicationController

  def index
    if admin_user?
      @users = User.all
    else
      render file: "/public/422.html"
    end
  end

  def update
    if admin_user?
      @user = User.find_by(id: params[:id])
      @user.update_attributes(update_user_role_params)
      redirect_to users_admin_index_path
    else
      render file: "/public/422.html"
    end
  end

  def destroy
    if admin_user?
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
