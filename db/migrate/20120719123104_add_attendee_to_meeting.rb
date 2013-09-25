class AddAttendeeToMeeting < ActiveRecord::Migration
  def self.up
  add_column :meetings , :attendee , :string
 
  end

  def self.down
  remove_column :meetings , :attendee
  end
end
