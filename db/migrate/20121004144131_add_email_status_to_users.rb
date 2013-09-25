class AddEmailStatusToUsers < ActiveRecord::Migration
  def self.up
   
   add_column :users , :email_status_reminder , :integer, :default => 0
  
  end

  def self.down
   
   remove_column :users , :email_status_reminder
  
  end
end
