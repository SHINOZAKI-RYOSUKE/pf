class FavoritesController < ApplicationController
  
  before_action :authenticate_user!
  
  
  def index
    @content = Content.find(params[:content_id])
  end

  def create
    @content = Content.find(params[:content_id])
    
    favorite = current_user.favorites.new(content_id: @content.id)
    favorite.save
    
    # ここから
    @content.create_notification_like!(current_user)
    # ここまで
  end

  def destroy
    @content = Content.find(params[:content_id])
    
    favorite = current_user.favorites.find_by(content_id: @content.id)
    favorite.destroy
  end

end
