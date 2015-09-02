class AddVenueCategoryIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :venue_category_id, :integer
  end
end
