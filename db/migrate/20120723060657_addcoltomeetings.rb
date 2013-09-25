class Addcoltomeetings < ActiveRecord::Migration
  def self.up
  add_column :meetings , :meeting_type, :string
  add_column :meetings , :to_meeting_time, :time
  end

  def self.down
  remove_column :meetings , :meeting_type
  remove_column :meetings , :to_meeting_time
  end
end
