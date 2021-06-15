class RelationshipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @user_A = user.followings
    @user_P = user.follower
  end

  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end

end
