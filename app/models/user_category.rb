require 'gcm'

class UserCategory < ActiveRecord::Base

  validates :name, presence: true

  has_many :user_user_categories
  has_many :users, through: :user_user_categories

  def self.send_gcm_to_all(message)
    gcm = GCM.new("AIzaSyCChwudE2ZPtMvDaeCpaKSXsiZnvQh_6uc")
    User.all.each do |user|
      registration_ids = [user.gcm_id]
      p "sending #{message}"
      options = {data: {category: "all", message: "#{message}"}, collapse_key: "updated_score"}
      response = gcm.send(registration_ids, options)
    end
  end

  def send_gcm(message, category)
    gcm = GCM.new("AIzaSyCChwudE2ZPtMvDaeCpaKSXsiZnvQh_6uc")
    self.users.each do |user|
      registration_ids = [user.gcm_id]
      p "sending #{message}"
      options = {data: {category: "#{category}", message: "#{message}"}, collapse_key: "updated_score"}
      response = gcm.send(registration_ids, options)
    end
  end
end
