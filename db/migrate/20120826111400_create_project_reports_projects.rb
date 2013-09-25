class CreateProjectReportsProjects < ActiveRecord::Migration
 def self.up
create_table :project_reports_projects, :id => false do |t|
      t.integer :project_id
      t.integer :project_report_id
  end
end

  def self.down
drop_table :project_reports_projects
  end
end
