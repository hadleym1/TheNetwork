class AddColumnsToPoll < ActiveRecord::Migration
  def change
   add_column :fan_polls, :option_1, :integer
   add_column :fan_polls, :option_2, :integer
   add_column :fan_polls, :option_3, :integer
   add_column :fan_polls, :option_4, :integer
   add_column :fan_polls, :option_5, :integer
  end
end
