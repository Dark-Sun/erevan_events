class CreatedVenueCategories < ActiveRecord::Migration

  def change
    create_table :venue_categories do |t|
      t.string     :name
      t.timestamps null: false
    end
  end

end
