class Addcoltoattendee < ActiveRecord::Migration
  def up
  add_column :attendees, :organization_id, :integer 
  end

  def down
  remove_column :attendees, :organization_id
  
  end
end
