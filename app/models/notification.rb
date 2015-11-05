class Notification < ActiveRecord::Base

  validates :message,          presence: true
  validates :message_armenian, presence: true
  validates :message_russian,  presence: true

  belongs_to :venue
  belongs_to :event

  has_and_belongs_to_many :users, join_table: :users_notifications

  just_define_datetime_picker :fire_time

  scope :pending, -> { where(sent: false) }
  scope :sent,    -> { where(sent: true) }

  scope :from_last_week, -> { where("fire_time > ? OR fire_time IS NULL", 1.week.ago) }

  def send_notification
    self.update_attributes(sent: true)
    self.users.each do |user|
      user.send_gcm(self)
      user.send_apns(self)
    end
  end

end