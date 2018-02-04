class Story < ApplicationRecord
  belongs_to :show
  belongs_to :storyable, polymorphic: true
end
