class AddUsagetoOthersalso < ActiveRecord::Migration

 def self.up
  add_column :statuses, :usage , :text
  add_column :timecodes, :usage, :text 

  end
  def self.down
  remove_column :statuses, :usage
  remove_column :timecodes, :usage
  end 

end
