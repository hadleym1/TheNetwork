class CreateFanRespondeds < ActiveRecord::Migration
  def change
    create_table :fan_respondeds do |t|
      t.integer :fan_id
      t.integer :responded_to

      t.timestamps null: false
    end
  end
end
