class CreateFanMessages < ActiveRecord::Migration
  def change
    create_table :fan_messages do |t|
      t.text :message

      t.timestamps null: false
    end
  end
end
