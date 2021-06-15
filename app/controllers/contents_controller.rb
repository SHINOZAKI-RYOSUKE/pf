class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def show
  end

  def edit
  end

  def new
  end
  
  
  private
  def user_params
    params.require(:content).permit(:content_image, :description)
  end
  
end
