class AddActualToProjects < ActiveRecord::Migration
  def self.up
  add_column :projects , :actual , :decimal, :precision => 10, :scale => 1
  end
  def self.down
  remove_column :projects , :actual 
  end
end
