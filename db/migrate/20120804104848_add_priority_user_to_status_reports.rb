class AddPriorityUserToStatusReports < ActiveRecord::Migration
  def self.up
  add_column :statusreports , :report_user ,:string
  add_column :statusreports , :report_priority ,:string   
  end
  def self.down
  
  remove_column :statusreports , :report_user
  remove_column :statusreports , :report_priority
  end
end
