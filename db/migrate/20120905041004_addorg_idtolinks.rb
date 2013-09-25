class AddorgIdtolinks < ActiveRecord::Migration
  
  def up
  add_column :links, :organization_id, :integer 
  end

  def down
  remove_column :links, :organization_id
  end
  
end
