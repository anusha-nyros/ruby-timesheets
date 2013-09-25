class AddorgIdtoIssues < ActiveRecord::Migration
  def up
  add_column :issues, :organization_id, :integer 
  end

  def down
  remove_column :issues, :organization_id
  end
end
