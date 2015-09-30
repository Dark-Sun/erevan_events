class AddTranslationsToUserCategories < ActiveRecord::Migration
  def change
    add_column :user_categories, :name_ru, :string
    add_column :user_categories, :name_arm, :string
  end
end
