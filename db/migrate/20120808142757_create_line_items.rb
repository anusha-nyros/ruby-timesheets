class CreateLineItems < ActiveRecord::Migration
    def self.up
    create_table :line_items do |t|
      t.string :status_details
      t.string :per_completed
      t.integer :statusreport_id
      t.integer :project_id
      t.string  :project_type
      t.string :title 
      t.text :notes 
      t.string :prq_number 
      t.string :action_required 
      t.string :priority 
      t.timestamps
    end
  end
  def self.down
  drop_table :line_items
  end
end
