class CreateUsersNotifications < ActiveRecord::Migration
  def change
    create_table :users_notifications do |t|
      t.integer :user_id
      t.integer :notification_id
    end
  end
end
