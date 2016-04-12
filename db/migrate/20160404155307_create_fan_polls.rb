class CreateFanPolls < ActiveRecord::Migration
  def change
    create_table :fan_polls do |t|
      t.string :question
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
