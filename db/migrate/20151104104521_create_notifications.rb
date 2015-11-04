class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message
      t.string :message_armenian
      t.string :message_russian
      t.datetime :fire_time
      t.integer :event_id
    end
  end
end
