class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admins_users_path, notice: "User deleted successfully."
    else
      redirect_to admins_users_path, alert: "Failed to delete user."
    end
  end
end
