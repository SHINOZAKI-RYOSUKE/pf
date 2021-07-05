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
    @contents_reverse = Content.order(created_at: :desc).page(params[:page]).per(8)
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

    # 画像が編集された場合
    if params[:content][:content_image].present? && params[:content][:content_image] != "{}"
      # railsの仕様で、nilではなく"{}"が返ってきてしまう問題の解決策が上記の右側。
      # パラメーター(画像)を「tempfile」として開いて変数に代入
      profile_image = File.open(params[:content][:content_image].tempfile)
      # Cloud Vision APIで画像分析して、分析結果を変数に代入
      result = Vision.image_analysis(profile_image)
    else
      # 画像が編集されてない場合は「true」を代入
      result = true
    end
    # 解析結果によって条件分岐
    if result == true
      @content.update(content_params)
      redirect_to content_path(@content.id), notice:"You have updated content successfully."
    elsif result == false
      flash[:notice] = '画像が不適切です'
      render 'edit'
    end


  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    @content.user_id = current_user.id

    # 画像が編集された場合
    if params[:content][:content_image].present? && params[:content][:content_image] != "{}"
      # railsの仕様で、nilではなく"{}"が返ってきてしまう問題の解決策が上記の右側。
      # パラメーター(画像)を「tempfile」として開いて変数に代入
      profile_image = File.open(params[:content][:content_image].tempfile)
      # Cloud Vision APIで画像分析して、分析結果を変数に代入
      result = Vision.image_analysis(profile_image)
    else
      flash[:notice] = '必要項目を記述してください'
      render 'new'
    end
    # 解析結果によって条件分岐
    if result == true
      if @content.save(content_params)
        redirect_to content_path(@content.id), notice:"You have updated content successfully."
      else
        flash[:notice] = '必要項目を記述してください'
      render 'new'
      end
    elsif result == false
      flash[:notice] = '画像が不適切です'
      render 'new'
    end

  end



  private

  def content_params
    params.require(:content).permit(:content_image, :description)
  end

end
