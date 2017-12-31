class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :show
  delegate :username, to: :user
end
