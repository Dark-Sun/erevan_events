class AddTranslationsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :name_ru, :string
    add_column :venues, :name_arm, :string
    add_column :venues, :description_ru, :text
    add_column :venues, :description_arm, :text
  end
end
