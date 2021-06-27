class Comment < ApplicationRecord
# relation-----------------------------------
  belongs_to :user
  belongs_to :content
  has_many :notifications, dependent: :destroy

# validates----------------------------------
  validates :comment,
    presence: true,
    length: { in: 1..1000 }


end
