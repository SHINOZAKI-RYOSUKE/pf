class UsersController < ApplicationController

  before_action :authenticate_user!


  def index
    @users = User.all.order(created_at: :desc)
    
    if params[:a] == "dm"
      @a = "dm"
    end
  end

  def show
    @user = User.find(params[:id])
    @contents_reverse = @user.contents.order(created_at: :desc)
    @favorite_contents_reverse = @user.favorite_contents.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice:"You have updated user successfully."
    else
      render "edit"
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :greeting)
  end

end
