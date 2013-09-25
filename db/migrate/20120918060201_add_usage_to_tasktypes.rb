class AddUsageToTasktypes < ActiveRecord::Migration
  
  def self.up
  add_column :tasktypes, :usage , :text
  end
  
  def self.down
  remove_column :tasktypes, :usage
  end

end
