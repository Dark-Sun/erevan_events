class AddPositionToVenueCategories < ActiveRecord::Migration
  def change
    add_column :venue_categories, :position, :integer
  end
end
