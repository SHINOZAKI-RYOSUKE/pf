class Room < ApplicationRecord
# relation----------------------------------
  has_many :chats
  has_many :user_rooms


end
