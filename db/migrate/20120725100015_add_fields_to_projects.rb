class AddFieldsToProjects < ActiveRecord::Migration
  def self.up
  
  add_column :projects, :priority ,:string
  add_column :projects, :owner,:string
  add_column :projects, :start_date ,:date
  add_column :projects, :end_date ,:date 
  
  end
  
  def self.down
 
  remove_column :projects, :priority
  remove_column :projects, :owner
  remove_column :projects, :start_date
  remove_column :projects, :end_date 

  end
end
