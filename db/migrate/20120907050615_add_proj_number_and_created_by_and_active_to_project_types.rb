class AddProjNumberAndCreatedByAndActiveToProjectTypes < ActiveRecord::Migration
  def change
    add_column :project_types, :proj_number, :string
    add_column :project_types, :created_by, :string
    add_column :project_types, :active, :boolean
  end
end
