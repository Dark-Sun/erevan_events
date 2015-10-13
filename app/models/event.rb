class Event < ActiveRecord::Base
  
  acts_as_paranoid
  
  belongs_to :venue

  has_many :favorite_events
  has_many :users, through: :favorite_events

  has_attached_file :photo, 
                       styles: { medium: "300x300#", thumb: "150x150#" }
                       
  validates_attachment_content_type :photo, content_type: ["image/jpg", "image/jpeg", "image/png"]

  # validates :name, presence: true, length: { maximum: 30 }

  validates :facebook_id, uniqueness: true, allow_blank: true
  just_define_datetime_picker :time
  validates :time, :presence => true

  def deleted
    deleted_at ? true : false
  end
  
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
