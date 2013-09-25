class Addcalnumtocalendar < ActiveRecord::Migration
 def up
  add_column :calendars, :cal_num, :integer 
  add_column :calendars, :activity, :text
  end

  def down
  remove_column :calendars, :cal_num
  remove_column :calendars, :activity
  end
end
