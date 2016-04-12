class CreateChatEvents < ActiveRecord::Migration
  def change
    create_table :chat_events do |t|
      t.integer :owner_id
      t.integer :target_id

      t.timestamps null: false
    end
  end
end
