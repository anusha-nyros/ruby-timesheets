class Addcolstoprojects < ActiveRecord::Migration
  def up
  add_column :projects, :status_details, :text
  add_column :projects, :per_completed, :integer
  end

  def down
  remove_column :projects, :status_details
  remove_column :projects, :per_completed
  end
end
