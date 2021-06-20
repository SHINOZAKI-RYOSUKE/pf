class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  attachment :profile_image


# relation-----------------------------------
  has_many :contents
  has_many :comments
  has_many :favorites
  has_many :chats
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  
  # 自分がフォローしているユーザーとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  # 自分がフォローされるユーザーとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  
# helper method------------------------------
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
 
  
# validates----------------------------------
  validates :name,
    presence: true,
    length: { in: 2..20 }
  
  validates :introduction,
    length: { maximum: 50 }

  validates :greeting,
    length: { maximum: 15 }


end
