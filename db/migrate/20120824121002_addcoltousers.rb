class Addcoltousers < ActiveRecord::Migration
  def up
     add_column :users, :superadmin, :boolean, :default => 0
  end

  def down
     remove_column :users, :superadmin
  end
end
