class CreateVenuePhotos < ActiveRecord::Migration
  def change
    create_table :venue_photos do |t|
      t.integer :venue_id
      t.string :photo_url
      t.string :thumb_url
      t.timestamps null: false
    end
  end
end
