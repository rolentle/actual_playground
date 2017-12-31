class Show < ApplicationRecord
  has_many :ratings

  has_attached_file :image, styles: {
    medium: '360x360>',
    thumb: '180x180>'
  }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\z}

  delegate :url, to: :image, prefix: true

  def self.by_avg_scores
    select("shows.*,
            count(ratings.id) as ratings_count,
           avg(ratings.score) as avg_rating")
      .left_outer_joins(:ratings)
      .group('shows.id')
      .order("count(ratings.id) desc,
             avg(ratings.score) desc")
  end

  def avg_rating
    ratings.average(:score).round(1) if ratings.any?
  end

  def user_rating(user)
    ratings.find_by(user: user)
  end
end
