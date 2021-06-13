class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contents
  has_many :comments
  has_many :favotites
  has_many :chats
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  
  has_many :followings, through: :active_relationships, source: :follower
  
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  
  has_many :followers, through: :passive_relationships, source: :following

end
