class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer    :venue_id
      t.string     :name
      t.datetime   :time
      t.attachment :photo
      t.timestamps null: false
    end
  end
end
