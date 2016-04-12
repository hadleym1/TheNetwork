class CreateFanMessageTypes < ActiveRecord::Migration
  def change
    create_table :fan_message_types do |t|
      t.integer :type
      t.integer :fan_id

      t.timestamps null: false
    end
  end
end
