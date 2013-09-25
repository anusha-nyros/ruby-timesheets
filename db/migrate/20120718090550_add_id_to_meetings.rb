class AddIdToMeetings < ActiveRecord::Migration
  def change
  add_column :meetings , :contact_id ,:integer
  add_column :meetings , :organization_id ,:integer
   add_index :meetings, :organization_id
   add_index :meetings, :contact_id
    
   end

 
end
