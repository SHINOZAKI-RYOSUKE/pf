class UserRoom < ApplicationRecord
# relation----------------------------------
  belongs_to :user
  belongs_to :room
  has_many :chats, through: :room, dependent: :destroy


end
