class RenameProjectTypeToProjectName < ActiveRecord::Migration
  def self.up
    rename_column :projects, :project_type ,:project_name
  end

  def self.down
   rename_column :projects,  :project_type ,:project_name
  end
end
