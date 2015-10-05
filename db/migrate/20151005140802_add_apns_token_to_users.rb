class AddApnsTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :apns_token, :string
  end
end
