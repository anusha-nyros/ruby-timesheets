class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :meeting_number
      t.date :meeting_date
      t.time :meeting_time
      t.string :meeting_location
      t.string :subject
      t.text :meeting_notes
      t.text :action_items

      t.timestamps
    end
  end

end
