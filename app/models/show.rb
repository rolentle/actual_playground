class Show < ApplicationRecord
  has_attached_file :image, styles: { medium: "360x360>", thumb: "180x180>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :ratings

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
    if ratings.any?
      ratings.average(:score).round(1)
    end
  end

  def image_url
    image.url
  end

  def user_rating(user)
    ratings.where(user: user).first
  end
end
