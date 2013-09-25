class Addcoltothread < ActiveRecord::Migration
  def up
  add_column :my_threads, :organization_id, :integer 
  end

  def down
  remove_column :my_threads, :organization_id
  
  end
end
