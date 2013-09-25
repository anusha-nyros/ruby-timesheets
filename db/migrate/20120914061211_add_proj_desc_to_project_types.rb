class AddProjDescToProjectTypes < ActiveRecord::Migration
  def change
    add_column :project_types, :proj_desc, :text
  end
end
