class Event < ActiveRecord::Base
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

  def original_photo_url
    photo.url(:original)
  end

  def medium_photo_url
    photo.url(:medium)
  end

  def thumb_photo_url
    photo.url(:thumb)
  end

  # def time=(time_yerevan)
    # offset = Time.now.in_time_zone("Yerevan").utc_offset # UTC+4
    # time_utc = time_yerevan - offset # yerevan to utc
    # write_attribute(:time, time_utc)
  # end

  def time_armenian
    self.time
    # self.time.in_time_zone("Yerevan").to_s# + Time.now.in_time_zone("Yerevan").time_zone.name
  end

end
