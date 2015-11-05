class AddVenueIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :venue_id, :integer
  end
end
