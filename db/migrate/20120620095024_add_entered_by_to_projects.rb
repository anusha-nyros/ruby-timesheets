class AddEnteredByToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects , :entered_by ,:string
  end
  
   def self.down
    remove_column :projects ,:entered_by 
   end
end
