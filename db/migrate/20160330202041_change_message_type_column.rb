class ChangeMessageTypeColumn < ActiveRecord::Migration
  def change
    rename_column :fan_message_types, :type, :message_type
  end
end
