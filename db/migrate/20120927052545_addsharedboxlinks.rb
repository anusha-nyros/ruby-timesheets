class Addsharedboxlinks < ActiveRecord::Migration
 def up
  add_column :links, :sharebox, :boolean
  end

  def down
  remove_column :links, :sharebox
  end
end
