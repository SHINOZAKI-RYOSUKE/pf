class Comment < ApplicationRecord
# relation-----------------------------------
  belongs_to :user
  belongs_to :content
  
  
# validates----------------------------------
  validates :comment, 
    presence: true,
    length: { in: 1..200 }


end
