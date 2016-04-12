class AddIdColumn < ActiveRecord::Migration
  def change
    rename_column :fan_messages, :type, :message_type
  end
end
