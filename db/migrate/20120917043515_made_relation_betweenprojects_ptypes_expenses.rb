class MadeRelationBetweenprojectsPtypesExpenses < ActiveRecord::Migration
  def up
  add_column :payments, :project_id, :integer
  add_column :payments, :project_type_id, :integer
  end

  def down
  remove_column :payments, :project_id
  remove_column :payments, :project_type_id
  end
  
end
