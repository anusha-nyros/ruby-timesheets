class CreateAttendeesMeetings < ActiveRecord::Migration
  def self.up
   create_table :attendees_meetings, :id => false do |t|
   t.references :attendee
   t.references :meeting
  end
 end

def self.down
drop_table :attendees_meetings
end
end
