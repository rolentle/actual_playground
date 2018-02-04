class Episode < ApplicationRecord
  belongs_to :campaign, optional: true
  has_one :story, as: :storyable
end
