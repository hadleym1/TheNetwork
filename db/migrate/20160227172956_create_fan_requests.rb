class CreateFanRequests < ActiveRecord::Migration
  def change
    create_table :fan_requests do |t|
      t.integer :user_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
