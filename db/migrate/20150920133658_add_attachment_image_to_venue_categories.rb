class AddAttachmentImageToVenueCategories < ActiveRecord::Migration
  def self.up
    change_table :venue_categories do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :venue_categories, :image
  end
end
