class ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url, :avg_rating, :user_rating
  has_many :ratings do
    if scope
      object.ratings.where.not(user: scope)
    else
      object.ratings
    end
  end

  def user_rating
    object.user_rating(scope) if scope
  end

  class RatingSerializer < ActiveModel::Serializer
    attributes :id, :score, :review, :username
  end
end
