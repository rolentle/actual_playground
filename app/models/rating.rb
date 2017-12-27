class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :show

  def username
    user.username
  end
end
