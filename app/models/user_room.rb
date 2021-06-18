class UserRoom < ApplicationRecord
# relation----------------------------------
  belongs_to :user
  belongs_to :room


end
