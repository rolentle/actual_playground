class Performer < ApplicationRecord
  has_many :performer_groups_performers
  has_many :performer_groups, through: :performer_groups_performers
  has_many :shows, as: :creator
end
