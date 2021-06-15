class Content < ApplicationRecord
  
  attachment :content_image
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
