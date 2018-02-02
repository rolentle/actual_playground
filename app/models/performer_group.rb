class PerformerGroup < ApplicationRecord
  has_many :performer_groups_performers
  has_many :performers, through: :performer_groups_performers
  has_many :shows, as: :creator
end
