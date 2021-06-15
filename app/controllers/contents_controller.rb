class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def show
    @content = Content.find(params[:id])
  end
  
  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to user_path(current_user.id)
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
