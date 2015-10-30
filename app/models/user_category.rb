require 'gcm'

class UserCategory < ActiveRecord::Base
  validates :name, presence: true

  has_many :user_user_categories
  has_many :users, through: :user_user_categories
  
end
