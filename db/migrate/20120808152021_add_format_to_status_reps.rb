class AddFormatToStatusReps < ActiveRecord::Migration
   def self.up
  add_column :statusreports , :format ,:string
  end
  def self.down
  remove_column :statusreports , :format 
  end
end
