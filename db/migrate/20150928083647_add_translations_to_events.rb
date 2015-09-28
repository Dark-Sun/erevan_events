class AddTranslationsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :name_ru, :string
    add_column :events, :name_arm, :string
    add_column :events, :description_ru, :string
    add_column :events, :description_arm, :string
  end
end
