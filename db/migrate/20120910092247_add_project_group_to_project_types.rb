class AddProjectGroupToProjectTypes < ActiveRecord::Migration
  def change
    add_column :project_types, :project_group, :string
  end
end
