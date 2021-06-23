class Room < ApplicationRecord
# relation----------------------------------
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy


end
