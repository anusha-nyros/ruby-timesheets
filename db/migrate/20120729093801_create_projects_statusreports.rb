class CreateProjectsStatusreports < ActiveRecord::Migration
 def self.up
create_table :projects_statusreports, :id => false do |t|
      t.integer :project_id
      t.integer :statusreport_id
  end
end

  def self.down
drop_table :projects_statusreports
  end
end
