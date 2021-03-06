require 'gcm'

class User < ActiveRecord::Base

  attr_accessor :password

  validates :email, :allow_blank => true,:uniqueness => { :case_sensitive => false } 

  # validates :email, presence: true, 
  #           # format: /\A\S+@.+\.\S+\z/,
  #           uniqueness: { case_sensitive: false }

 # validates :name,     presence: true
  # validates :password, presence: true
  #before_save :password_set?

  # accepts_nested_attributes_for :gcm_ids

  has_many :user_user_categories, inverse_of: :user

  has_many :user_categories, through: :user_user_categories
  accepts_nested_attributes_for :user_categories

  has_many :favorite_venues, inverse_of: :user
  has_many :venues, through: :favorite_venues

  has_many :favorite_events, inverse_of: :user
  has_many :events, through: :favorite_events

  has_and_belongs_to_many :notifications, join_table: :users_notifications

  def password=(password)
    self.salt               = BCrypt::Engine.generate_salt
    self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  end


  def password_set?
    self.encrypted_password ? true : false
  end

  # def password
  #   encrypted_password
  # end

  def self.authenticate(email: email, password: password)
    user = User.find_by_email(email)
    return false unless user
    (user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)) ? user : false
  end
  
  def send_gcm
    gcm = GCM.new("AIzaSyCf-nVGYI_7yTLNz29LABOCHdGUAyV5YmA")
    registration_ids = [self.gcm_id]
    options = {data: {score: "123"}, collapse_key: "updated_score"}
    response = gcm.send(registration_ids, options)
  end

  def log_in
    self.update_attributes!(logged_in: true)
  end

  def log_out
    self.update_attributes!(logged_in: false)
  end

  def logged_in?
    logged_in
  end

  def send_gcm(notification)
    gcm = GCM.new("AIzaSyCChwudE2ZPtMvDaeCpaKSXsiZnvQh_6uc")
    registration_ids = [self.gcm_id]
    options = { data: {id:    "#{notification.id}", 
                message:      "#{notification.message}", 
                message_arm:  "#{notification.message_armenian}", 
                message_ru:   "#{notification.message_russian}",
                event_id:   "#{notification.event_id}", 
                venue_id:   "#{notification.venue_id}"},
                collapse_key: "update_scope",
                time_to_live: 43200,
                delay_while_idle: true
              }
    response = gcm.send(registration_ids, options)
  end

  def send_apns(notification)
    return if (self.apns_token.nil? || !self.logged_in)
    APNS.send_notification(self.apns_token, alert: notification.message_armenian, badge: 0, sound: 'default', 
      other: {
         "id"       => notification.id,
         "venue_id" =>  notification.venue_id,
         "event_id" =>  notification.event_id
      } )
  end

  def sent_notifications
    self.notifications.sent.from_last_week
  end

end