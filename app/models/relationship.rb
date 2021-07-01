class Relationship < ApplicationRecord
# relation----------------------------------
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"
  
  
  
  def self.looks(word)
    @users_follow = user.followings.where("name LIKE?","%#{word}%")
  end
  
  def self.looks(word)
    @users_follower = user.followers.where("name LIKE?","%#{word}%")
  end


end
