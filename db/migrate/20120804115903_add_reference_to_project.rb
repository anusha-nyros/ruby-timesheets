class AddReferenceToProject < ActiveRecord::Migration
 def self.up
  add_column :projects , :reference, :string
  end

  def self.down
  remove_column :projects , :reference
  end
end
