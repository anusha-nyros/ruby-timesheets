class AddTaskTypeToProjectChanges < ActiveRecord::Migration
  def self.up
  add_column :project_changes, :tasktype ,:string
  add_column :project_changes, :prev_tasktype,:string 

  end
  def self.down
  remove_column :project_changes, :tasktype
  remove_column :project_changes, :prev_tasktype
  end 
end
