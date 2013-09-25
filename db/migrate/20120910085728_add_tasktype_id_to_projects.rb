class AddTasktypeIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :tasktype_id, :integer
  end
end
