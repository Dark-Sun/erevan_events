class VenueCategory < ActiveRecord::Base
  
  acts_as_paranoid

  has_many :venues

  validates :name, presence: true

  has_attached_file :image, styles: { thumb: "225x225" }
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]

  def original_image_url
      image.url(:original)
  end

  def thumb_image_url
    image.url(:thumb)
  end

  def deleted
    deleted_at ? true : false
  end

end