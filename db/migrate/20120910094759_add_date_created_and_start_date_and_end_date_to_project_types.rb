class AddDateCreatedAndStartDateAndEndDateToProjectTypes < ActiveRecord::Migration
  def change
    add_column :project_types, :date_created, :date
    add_column :project_types, :start_date, :date
    add_column :project_types, :end_date, :date
  end
end
