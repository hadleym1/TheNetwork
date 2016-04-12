class CreateFanResponses < ActiveRecord::Migration
  def change
    create_table :fan_responses do |t|
      t.text :response
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
