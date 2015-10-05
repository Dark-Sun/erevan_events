require 'gcm'

class UserCategory < ActiveRecord::Base
  @@unique_id = 0
  validates :name, presence: true

  has_many :user_user_categories
  has_many :users, through: :user_user_categories

  def initialize
    @@unique_id += 1
  end

  def self.get_unique_id
    p "=============================================="
    p @@unique_id
    p "=============================================="
    @@unique_id
  end

  def self.send_gcm_to_all(message, message_arm: message_arm, message_ru: message_ru)
    @@unique_id += 1
    gcm = GCM.new("AIzaSyCChwudE2ZPtMvDaeCpaKSXsiZnvQh_6uc")
    User.all.each do |user|
      registration_ids = [user.gcm_id]
      options = { data: {id: self.get_unique_id, category: "all", message: "#{message}", message_arm: "#{message_arm}", 
                  message_ru: "#{message_ru}"}, collapse_key: "updated_score" }
      p "sending #{options}"    
      response = gcm.send(registration_ids, options)
    end
  end

  def send_gcm(message, message_arm: message_arm, message_ru: message_ru, category: category)
      @@unique_id += 1
    gcm = GCM.new("AIzaSyCChwudE2ZPtMvDaeCpaKSXsiZnvQh_6uc")
    self.users.each do |user|
      registration_ids = [user.gcm_id]
      options = { data: {id: self.get_unique_id, category: "all", message: "#{message}", message_arm: "#{message_arm}", 
                  message_ru: "#{message_ru}"}, collapse_key: "updated_score" }
      p "sending #{options}"    
      response = gcm.send(registration_ids, options)
    end
  end
end
