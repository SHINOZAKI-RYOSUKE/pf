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
    redirect_to user_path(current_user)
  end

  def edit
    
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
