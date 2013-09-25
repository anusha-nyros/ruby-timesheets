class Addcolstocalendar < ActiveRecord::Migration
  def up
  add_column :calendars, :organization_id, :integer 
  add_column :calendars, :user_id, :integer
  end

  def down
  remove_column :calendars, :organization_id
  remove_column :calendars, :user_id
  end
end
