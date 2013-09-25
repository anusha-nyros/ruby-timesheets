class Addcoltotimecode < ActiveRecord::Migration
  def up
  add_column :timecodes, :organization_id, :integer 
  end

  def down
  remove_column :timecodes, :organization_id
  
  end
end
