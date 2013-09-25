class AddMeetingFieldsToMeetings < ActiveRecord::Migration
  def self.up
  add_column :meetings , :meeting_connection, :string
  add_column :meetings , :meeting_tool, :string
  add_column :meetings , :meeting_attnds ,:string
  end
  def self.down
  remove_column :meetings , :meeting_connection
  remove_column :meetings , :meeting_tool
  remove_column :meetings , :meeting_attnds 
  end 
end
