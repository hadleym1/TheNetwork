class CreateFanPollOptions < ActiveRecord::Migration
  def change
    create_table :fan_poll_options do |t|
      t.string :option
      t.integer :poll_id

      t.timestamps null: false
    end
  end
end
