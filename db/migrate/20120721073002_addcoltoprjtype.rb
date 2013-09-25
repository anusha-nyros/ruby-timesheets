class Addcoltoprjtype < ActiveRecord::Migration
def up
  add_column :project_types, :organization_id, :integer 
  end

  def down
  remove_column :project_types, :organization_id
  
  end
end
