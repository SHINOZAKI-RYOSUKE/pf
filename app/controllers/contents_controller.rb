class ContentsController < ApplicationController
  # TOPページと詳細ページはログイン前でも閲覧のみ可能。
  before_action :authenticate_user!, except:[:index, :show, :guest_sign_in]
  
  
  
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      #user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      user.name = "ゲスト"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def index
    @contents_reverse = Content.all.order(created_at: :desc)
  end

  def show
    @content = Content.find(params[:id])
    
    @comments = Comment.all
    @c_comment = Comment.new
  end
  
  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to user_path(current_user.id), notice:"You have destroy content successfully."
  end

  def edit
    @content = Content.find(params[:id])
    if @content.user != current_user
      redirect_to content_path(@content)
    end
  end
  
  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      redirect_to content_path(@content.id), notice:"You have updated content successfully."
    else
      render "edit"
    end
  end

  def new
    @content = Content.new
  end
  
  def create
    @content = Content.new(content_params)
    @content.user_id = current_user.id
    if @content.save
    redirect_to content_path(@content.id), notice:"You have created content successfully."
    else
    render "new"
    end
  end
  
  
  
  private
  
  def content_params
    params.require(:content).permit(:content_image, :description)
  end
  
end
