class CreateGcmId < ActiveRecord::Migration
  def change
    create_table :gcm_ids do |t|
      t.string :gcm_id
      t.integer :user_id
    end
  end
end
