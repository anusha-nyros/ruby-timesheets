class CreateMeetingAttachments < ActiveRecord::Migration
  def change
    create_table :meeting_attachments do |t|
      t.string :doc
      t.integer :meeting_id

      t.timestamps
    end
  end
end
