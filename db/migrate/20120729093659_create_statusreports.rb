class CreateStatusreports < ActiveRecord::Migration
   def self.up
    create_table :statusreports do |t|
      t.string :report_number
      t.date :report_date
      t.time :report_time
      t.string :send_to
      t.string :sent_by
      t.string :subject
      t.integer :organization_id

      t.timestamps
    end
   
   add_index :statusreports, :organization_id
  end
  def self.down
  drop_table :statusreports
  end 
end
