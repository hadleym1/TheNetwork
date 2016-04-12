class CreateFans < ActiveRecord::Migration
  def change
    create_table :fans do |t|
      t.integer :user_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
