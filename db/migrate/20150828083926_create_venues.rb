class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string     :name
      t.attachment :photo
      t.string     :fb_page
      t.string     :address
      t.string     :phone
      t.float      :longtitude
      t.float      :latitude
      t.timestamps null: false
    end
  end
end
