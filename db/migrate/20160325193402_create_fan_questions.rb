class CreateFanQuestions < ActiveRecord::Migration
  def change
    create_table :fan_questions do |t|
      t.text :question
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
