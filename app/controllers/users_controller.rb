class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if@user.update(user_params)
    redirect_to user_path(@user.id), notice:"You have updated user successfully."
    else
    render "edit"
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image_id, :introduction, :greeting)
  end
  
end
