class Chat < ApplicationRecord
# relation------------------------------------
  belongs_to :user
  belongs_to :room
  
  
# validates-----------------------------------
  validates :message,
    presence: true,
    length: { maximum: 300 }


end
