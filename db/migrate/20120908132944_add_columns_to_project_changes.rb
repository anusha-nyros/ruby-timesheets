class AddColumnsToProjectChanges < ActiveRecord::Migration
   def self.up
  add_column :project_changes ,:prev_status_details ,:text
  add_column :project_changes ,:prev_per_completed ,:integer
  add_column :project_changes ,:prev_project_type ,:string
  add_column :project_changes ,:prev_title ,:string
  add_column :project_changes ,:prev_notes ,:text
  add_column :project_changes ,:prev_action_required ,:string
  add_column :project_changes ,:prev_priority ,:string
  add_column :project_changes ,:prev_schedule_date ,:date
  add_column :project_changes ,:prev_start_date ,:date
  add_column :project_changes ,:prev_end_date ,:date
  add_column :project_changes ,:prev_status_date ,:date
  add_column :project_changes ,:prev_reference ,:string
  add_column :project_changes ,:prev_owner ,:string
  add_column :project_changes ,:prev_amount ,:decimal,:precision => 10, :scale => 1
  add_column :project_changes ,:prev_contact_id ,:integer
  add_column :project_changes ,:prev_analysis ,:text
  add_column :project_changes ,:prev_active ,:string
add_column :project_changes ,:prev_suppliername ,:string
  change_column :project_changes , :status_details ,:text
  change_column :project_changes , :per_completed ,:integer
  end
def self.down
  remove_column :project_changes ,:prev_status_details 
  remove_column :project_changes ,:prev_per_completed
  remove_column :project_changes ,:prev_project_type
  remove_column :project_changes ,:prev_title
  remove_column :project_changes ,:prev_notes
  remove_column :project_changes ,:prev_action_required
  remove_column :project_changes ,:prev_priority
  remove_column :project_changes ,:prev_schedule_date
  remove_column :project_changes ,:prev_start_date
  remove_column :project_changes ,:prev_end_date
  remove_column :project_changes ,:prev_status_date
  remove_column :project_changes ,:prev_reference
  remove_column :project_changes ,:prev_owner
  remove_column :project_changes ,:prev_amount
  remove_column :project_changes ,:prev_contact_id
  remove_column :project_changes ,:prev_analysis
  remove_column :project_changes ,:prev_active
remove_column :project_changes ,:prev_suppliername
 change_column :project_changes , :status_details ,:string
  change_column :project_changes , :per_completed ,:string

end 
end
