class SearchesController < ApplicationController

  before_action :authenticate_user!


  def search_result

    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks( params[:word])
      
    elsif @range == "Follow"
      @Follows = current_user.followings.looks(params[:word])
      
    elsif @range == "Follower"
      @Followers = current_user.followers.looks(params[:word])
    end

  end




  # def search_result
  #   @word = params[:word]
  #   @users = User.looks(params[:word])
  #   @users_follow = user.followings.looks(params[:word])
  #   @users_follower = user.followers.looks(params[:word])
  # end

end
