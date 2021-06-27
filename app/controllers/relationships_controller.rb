class RelationshipsController < ApplicationController
  
  before_action :authenticate_user!
  
  
  def index
    user = User.find(params[:user_id])
    @users_A = user.followings
    @users_P = user.followers
  end

  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    
    # ここから
    user = User.find(params[:user_id])
    user.create_notification_follow!(current_user)
    # ここまで
    
    redirect_to request.referer
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to request.referer
  end

end
