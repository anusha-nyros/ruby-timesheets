class AddColumnsToProjects < ActiveRecord::Migration
  def up
     add_column :projects, :active, :boolean, :default => 1
     add_column :projects, :action_required, :string
     add_column :projects, :schedule_date, :date
  end

  def down
     remove_column :projects, :active
     remove_column :projects, :action_required
     remove_column :projects, :schedule_date
  end
end
