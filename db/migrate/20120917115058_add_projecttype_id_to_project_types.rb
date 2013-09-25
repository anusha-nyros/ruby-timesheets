class AddProjecttypeIdToProjectTypes < ActiveRecord::Migration
  def change
    add_column :project_types, :projecttype_id, :integer
  end
end
