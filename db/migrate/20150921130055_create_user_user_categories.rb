class CreateUserUserCategories < ActiveRecord::Migration
  def change
    create_table :user_user_categories do |t|
      t.integer :user_id
      t.integer :user_category_id

      t.timestamps null: false
    end
  end
end
