class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string     :name
      t.attachment :photo
      t.attachment :cover
      t.string     :fb_page
      t.text       :description
      t.string     :address
      t.string     :phone
      t.float      :longitude
      t.float      :latitude
      t.timestamps null: false
    end
  end
end
