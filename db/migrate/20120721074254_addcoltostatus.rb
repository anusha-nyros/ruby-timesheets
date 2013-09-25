class Addcoltostatus < ActiveRecord::Migration
  def up
  add_column :statuses, :organization_id, :integer 
  end

  def down
  remove_column :statuses, :organization_id
  
  end
end
