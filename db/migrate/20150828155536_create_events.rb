class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer    :venue_id
      t.string     :name
      t.datetime   :time
      t.text       :description
      t.attachment :photo
      t.integer    :facebook_id, :limit => 8
      t.timestamps null: false
    end
  end
end
