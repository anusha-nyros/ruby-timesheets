class AddAnalysisToProjects < ActiveRecord::Migration
  def self.up
  add_column :projects , :analysis ,:text

  end
  
  def self.down
    remove_column :projects , :analysis
  end 
end
