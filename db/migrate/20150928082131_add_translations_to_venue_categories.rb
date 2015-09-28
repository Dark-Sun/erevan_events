class AddTranslationsToVenueCategories < ActiveRecord::Migration
  def change
    add_column :venue_categories, :name_ru, :string
    add_column :venue_categories, :name_arm, :string
  end
end
