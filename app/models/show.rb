class Show < ApplicationRecord
  has_attached_file :image, styles: { medium: "360x360>", thumb: "180x180>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
