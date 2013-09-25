class CreateProjectChanges < ActiveRecord::Migration
  def self.up
    create_table :project_changes do |t|
      t.string :status_details
      t.string :per_completed
      t.integer :project_id
      t.string  :project_type
      t.string :title 
      t.text :notes 
      t.string :prq_number 
      t.string :action_required 
      t.string :priority
      t.date :schedule_date
      t.date :start_date
      t.date :end_date
      t.date :status_date
      t.string :entered_by 
      t.string :reference
      t.string :owner
      t.decimal :amount,:precision => 10, :scale => 1
      t.decimal :variance,:precision => 10, :scale => 1
      t.decimal :percent_variance,:precision => 10, :scale => 1
      t.decimal :actual,:precision => 10, :scale => 1
      t.integer :contact_id
      t.integer :organization_id
      t.text :analysis
      t.string :active
      t.string :suppliername
      t.string :updated_by
      t.timestamps
    end
  end


  def self.down
  drop_table :project_changes
  end 
end
