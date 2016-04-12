class AddFanIdColumn < ActiveRecord::Migration
  def change
    add_column :fan_responses, :fan_id, :integer
  end
end
