class FavoritesController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    user = User.find(params[:user_id])
    @users = user.favorites
  end

  def create
    @content = Content.find(params[:content_id])
    
    favorite = current_user.favorites.new(content_id: @content.id)
    favorite.save
  end

  def destroy
    @content = Content.find(params[:content_id])
    
    favorite = current_user.favorites.find_by(content_id: @content.id)
    favorite.destroy
  end

end
