class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  attachment :profile_image


# relation-----------------------------------
  has_many :contents, dependent: :destroy
  has_many :comments, dependent: :destroy
  #has_many :content_comments, through: :contents, source: :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_contents, through: :favorites, source: :content, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms, dependent: :destroy

  # 自分がフォローしているユーザーとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower, dependent: :destroy
  # 自分がフォローされるユーザーとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following, dependent: :destroy
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


# helper method------------------------------
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.looks(word)
    @user = User.where("name LIKE?","%#{word}%")
  end
  
  
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

# validates----------------------------------
  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 2..20 }

  validates :introduction,
    length: { maximum: 300 }

  validates :greeting,
    length: { maximum: 20 }


end
