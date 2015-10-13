class AddDeletedAtToVenueCategories < ActiveRecord::Migration
  def change
    add_column :venue_categories, :deleted_at, :datetime
    add_index :venue_categories, :deleted_at
  end
end
