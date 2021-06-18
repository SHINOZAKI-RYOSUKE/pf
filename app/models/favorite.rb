class Favorite < ApplicationRecord
# relation----------------------------------
  belongs_to :user
  belongs_to :content


end
