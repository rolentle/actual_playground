class RssFeedEpisodeSerializer < ActiveModel::Serializer
  attributes :title, :published_at, :description, :duration_time
end
