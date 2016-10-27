class UsersController < ApplicationController

  def index
    if current_user && current_user.role == "Admin"
      @users = User.all
    else
      render file: "/public/422.html"
    end
  end

  def edit
    @user.find_by(id: params[:id])
    p "Got through here!"
    p params
  end

  def update
    p "Got through here!"
    p params

  end

  def destroy
  end


end
