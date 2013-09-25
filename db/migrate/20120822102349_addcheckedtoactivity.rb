class Addcheckedtoactivity < ActiveRecord::Migration
   def up
     add_column :activities, :doc_check, :boolean, :default => 0
  end

  def down
     remove_column :activities, :doc_check
  end
end
