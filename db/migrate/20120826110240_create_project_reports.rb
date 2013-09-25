class CreateProjectReports < ActiveRecord::Migration
     def self.up
    create_table :project_reports do |t|
      t.string :pdf_number
      t.string :report_user
      t.integer :organization_id

      t.timestamps
    end

  end
   
  def self.down

   drop_table :project_reports

  end 
end
