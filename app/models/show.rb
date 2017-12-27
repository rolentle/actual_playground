class Show < ApplicationRecord
  has_attached_file :image, styles: { medium: "360x360>", thumb: "180x180>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :ratings

  def avg_rating
    ratings.sum(:score) / ratings.count
  end

  def image_url
    image.url
  end

  def user_rating(user)
    ratings.where(user: user).first
  end
end
