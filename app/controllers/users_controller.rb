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
    
    # 画像が編集された場合
    if params[:user][:profile_image].present? && params[:user][:profile_image] != "{}"
      # パラメーター(画像)を「tempfile」として開いて変数に代入
      profile_image = File.open(params[:user][:profile_image].tempfile)
      # Cloud Vision APIで画像分析して、分析結果を変数に代入
      result = Vision.image_analysis(profile_image)
    else
      # 画像が編集されてない場合は「true」を代入
      result = true
    end
    # 解析結果によって条件分岐
    if result == true
      @user.update(user_params)
      redirect_to user_path(@user), notice:"You have updated user successfully."
    elsif result == false
      flash[:notice] = '画像が不適切です'
      render 'edit'
    end

  end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :greeting)
  end

end
