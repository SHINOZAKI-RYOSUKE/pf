class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :contents
  has_many :comments
  has_many :favorites
  has_many :chats
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  
  has_many :followings, through: :active_relationships, source: :follower
  
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  
  has_many :followers, through: :passive_relationships, source: :following
  
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  
  validates :name,
   presence: true,
   uniqueness: true,
   length: { minimum: 2, maximum: 20 }
  
  validates :introduction,
   length: { maximum: 50 }

end
