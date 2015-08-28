class Event < ActiveRecord::Base
  belongs_to :venue

  has_attached_file :photo, 
                       styles: { medium: "300x300#", thumb: "150x150#" }
                       
  validates_attachment_content_type :photo, content_type: ["image/jpg", "image/jpeg", "image/png"]

  validates :name, presence: true, length: { maximum: 30 }

  just_define_datetime_picker :time
  validates :time, :presence => true

  def original_photo_url
    photo.url(:original)
  end

  def medium_photo_url
    photo.url(:medium)
  end

  def thumb_photo_url
    photo.url(:thumb)
  end

end
