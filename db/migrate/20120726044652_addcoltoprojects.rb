class Addcoltoprojects < ActiveRecord::Migration
  def self.up
  add_column :projects , :status_date , :date
 
  end

  def self.down
  remove_column :projects , :status_date
  end
end
