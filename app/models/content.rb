class Content < ApplicationRecord
  
  attachment :content_image
  
  
# relation-----------------------------------
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  
# helper method------------------------------
  def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
  end
  
  
# validates----------------------------------
	validates :description, 
	  presence: true, 
	  length: { maximum: 200 }


end
